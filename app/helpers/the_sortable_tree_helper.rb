module TheSortableTreeHelper
  # Publicated by MIT
  # Nested Set View Helper
  # Ilya Zykin, zykin-ilya@ya.ru, Russia, Ivanovo 2009-2013
  # github.com/the-teacher
  TREE_RENDERERS = {
    :tree     => RenderTreeHelper,
    :sortable => RenderSortableTreeHelper
  }

  ###############################################
  # Common Base Methods
  ###############################################
  def define_class_of_elements_of tree
    case
      when tree.is_a?(ActiveRecord::Relation) then tree.name.to_s.underscore.downcase
      when tree.empty?                        then nil
      else tree.first.class.to_s.underscore.downcase
    end
  end

  def build_tree_html context, render_module, options = {}
    @tree_renderer = render_module::Render.new(context, options)
    @tree_renderer.render_node()
  end

  ###############################################
  # Server Side Render Tree Helper
  ###############################################
  def build_server_tree(tree, options= {})
    result = ''
    opts   = {
      :id    => :id,      # node id field
      :node  => nil,      # node
      :title => :title,   # name of title fileld
      :type  => :tree,    # tree type
      :root  => false,    # is it root node?
      :level => 0,        # recursion level
      :boost => [],       # BOOST! array
      :namespace => [],   # :admin
      # SORTABLE options
      :max_levels => 3,   # deep of sortable tree
      # COMMENTS options
      :node_id           => :id,
      :contacts_field    => :email,
      :content_field     => :content,
      :raw_content_field => :raw_content
    }.merge!(options)

    # Basic vars
    root = opts[:root]
    node = opts[:node]

    # namespace prepare [Rails require]
    opts[:namespace] = Array.wrap opts[:namespace]

    # Module with **Render** class
    opts[:render_module] = TREE_RENDERERS[opts[:type]] unless opts[:render_module]

    # Define tree class
    opts[:klass] = define_class_of_elements_of(tree) unless opts[:klass]

    # BOOST PATCH (BUILD ONCE)
    if opts[:boost].empty?
      tree.each do |item|
        num = item.parent_id || 0
        opts[:boost][num] = [] unless opts[:boost][num]
        opts[:boost][num].push item
      end
    end

    unless node
      roots = opts[:boost][0]

      # define roots, if it's need
      if roots.empty? && !tree.empty?
        min_parent_id = tree.map(&:parent_id).compact.min
        roots = tree.select{ |elem| elem.parent_id == min_parent_id }
      end

      # children rendering
      roots.each do |root|
        _opts  =  opts.merge({ :node => root, :root => true, :level => opts[:level].next, :boost => opts[:boost] })
        result << build_server_tree(tree, _opts)
      end
    else
      children_res = ''
      children     = opts[:boost][node.id]
      opts.merge!({ :has_children => children.blank? })

      unless children.nil?
        children.each do |elem|
          _opts        =  opts.merge({ :node => elem, :root => false, :level => opts[:level].next, :boost => opts[:boost] })
          children_res << build_server_tree(tree, _opts)
        end
      end

      result << build_tree_html(self, opts[:render_module], { :root => root, :node => node, :children => children_res, :opts => opts })
    end
    raw result
  end
end

# # types:
# #   tree
# #   sortable
# #   comments
# #   expandable [todo]
# #   select/options [todo]
# def build_client_tree(tree, options= {})
#   opts = {
#     max_levels: 3,
#     :type       => :tree,
#     :side       => :client,
#     :path       => false,
#     :title      => :title,
#     :klass      => define_class_of_elements_of(tree),
#     # comments options
#     :node_id           => :id,
#     :contacts_field    => :email,
#     :content_field     => :content,
#     :raw_content_field => :raw_content
#   }.merge! options

#   # RAILS require
#   opts[:namespace] = Array.wrap opts[:namespace]

#   # PATH building
#   opts[:path] = "#{opts[:type]}/#{opts[:side]}" unless opts[:path]

#   render :partial => "#{opts[:path]}/tree", :locals => { :tree => tree, :opts => opts }
# end