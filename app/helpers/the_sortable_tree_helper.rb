module TheSortableTreeHelper
  # Publicated by MIT
  # Nested Set View Helper
  # Ilya Zykin, zykin-ilya@ya.ru, Russia, Ivanovo 2009-2012
  # github.com/the-teacher
  #-------------------------------------------------------------------------------------------------------

  # = sortable_tree @pages,    :new_url => new_page_url, :max_levels => 5
  # = sortable_tree @products, :new_url => new_product_url, :path => 'products/the_sortable_tree'
  # = sortable_tree @catalogs, :namespace => :admin, :new_url => new_catalog_url, :max_levels => 5

  def define_class_of_elements_of tree
    case
      when tree.is_a?(ActiveRecord::Relation) then tree.name.to_s.underscore.downcase
      when tree.empty?                        then nil
      else tree.first.class.to_s.underscore.downcase
    end
  end

  # types:
  #   tree
  #   sortable
  #   comments
  #   expandable [todo]
  #   select/options [todo]
  def build_tree(tree, options= {})
    opts = {
      max_levels: 3,
      :type       => :tree,
      :side       => :client,
      :path       => false,
      :title      => :title,
      :klass      => define_class_of_elements_of(tree),
      # comments options
      :node_id           => :id,
      :contacts_field    => :email,
      :content_field     => :content,
      :raw_content_field => :raw_content
    }.merge! options

    # RAILS require
    opts[:namespace] = Array.wrap opts[:namespace]

    # PATH building
    opts[:path] = "#{opts[:type]}/#{opts[:side]}" unless opts[:path]

    render :partial => "#{opts[:path]}/tree", :locals => { :tree => tree, :opts => opts }
  end

  ###############################################
  # Server Side Render Tree Helper [deprecated and slow]
  ###############################################
  def server_build_tree(tree, options= {})
    result = ''
    opts   = {
      :id    => :id,        # node id field
      :node  => nil,        # node
      :root  => false,      # is it root node?
      :level => 0           # recursion level
    }.merge!(options)

    root = opts[:root]
    node = opts[:node]

    unless node
      roots = tree.select{ |elem| elem.parent_id.nil? }

      # TODO: try to remove compact
      # children rendering
      if roots.empty? && !tree.empty?
        min_parent_id = tree.map(&:parent_id).compact.min
        roots = tree.select{ |elem| elem.parent_id == min_parent_id }
      end

      roots.each do |root|
        _opts  =  opts.merge({:node => root, :root => true, :level => opts[:level].next})
        result << server_render_tree(tree, _opts)
      end
    else
      children_res = ''
      children = tree.select{|elem| elem.parent_id == node.id}
      opts.merge!({:has_children => children.blank?})
      children.each do |elem|
        _opts        =  opts.merge({:node => elem, :root => false, :level => opts[:level].next})
        children_res << server_render_tree(tree, _opts)
      end
      result << render(:partial => "#{opts[:path]}/node", :locals => {:opts => opts, :root => root, :node => node, :children => children_res})
    end
    raw result
  end
  ###############################################
  # ~Server Side Render Tree Helper
  ###############################################
end