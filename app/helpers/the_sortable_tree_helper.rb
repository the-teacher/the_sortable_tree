module TheSortableTreeHelper
  # Publicated by MIT
  # Nested Set View Helper
  # Ilya Zykin, zykin-ilya@ya.ru, Russia, Ivanovo 2009-2012
  # github.com/the-teacher
  #-------------------------------------------------------------------------------------------------------

  # = sortable_tree @pages, :new_url => new_page_url, :max_levels => 5
  # = sortable_tree @products, :new_url => new_product_url, :path => 'products/the_sortable_tree'

  def define_class_of_elements_of tree
    return nil if tree.empty?
    tree.first.class.to_s.downcase
  end

  def sortable_tree(tree, options= {})
    title = options[:title] || :title
    path  = options[:path]  || :the_sortable_tree
    max_levels = options[:max_levels] || 3
    klass = define_class_of_elements_of tree
    tree  = sortable_tree_builder(tree, options.merge!({:path => path, :klass => klass, :title => title, :max_levels => max_levels}))
    render :partial => "#{path}/tree", :locals => { :tree => tree, :opts => options }
  end

  def sortable_tree_builder(tree, options= {})
    result = ''
    opts = {
      :id => :id,           # node id field
      :node => nil,         # node
      :root => false,       # is it root node?
      :level => 0           # recursion level
    }.merge!(options)

    root = opts[:root]
    node = opts[:node]

    unless node
      roots = tree.select{|elem| elem.parent_id.nil?}      
      roots.each do |root|
        _opts = opts.merge({:node => root, :root => true, :level => opts[:level].next})
        result << sortable_tree_builder(tree, _opts)
      end
    else
      children_res = ''
      children = tree.select{|elem| elem.parent_id == node.id}
      opts.merge!({:has_children => children.blank?})
      children.each do |elem|
        _opts = opts.merge({:node => elem, :root => false, :level => opts[:level].next})
        children_res << sortable_tree_builder(tree, _opts)
      end
      result << render(:partial => "#{opts[:path]}/item", :locals => {:opts => opts, :root => root, :node => node, :children => children_res})
    end
    raw result
  end# sortable_tree_builder
end# module