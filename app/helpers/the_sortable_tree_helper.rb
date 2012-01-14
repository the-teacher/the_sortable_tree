module TheSortableTreeHelper
  # Publicated by MIT
  # Nested Set View Helper
  # Ilya Zykin, zykin-ilya@ya.ru, Russia, Ivanovo 2009-2012
  # github.com/the-teacher
  #-------------------------------------------------------------------------------------------------------
  
  # = sortable_tree @pages, :new_url => new_page_url
  # = sortable_tree @products, :new_url => new_product_url, :path => 'products/the_sortable_tree'

  def define_class_of_elements_of tree
    return nil if tree.empty?
    tree.first.class.to_s.downcase
  end

  def sortable_tree(tree, options= {})
    title = options[:title] || :title
    path  = options[:path]  || :the_sortable_tree
    max_levels =  options[:max_levels] || 3
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
      :level => 0,          # recursion level
      #:clean => true       # delete element from tree after rendering. ~25% time economy when rendering tree once on a page
    }.merge!(options)

    node = opts[:node]
    root = opts[:root]

    unless node
      roots = tree.select{|elem| elem.parent_id.nil?}      
      # render roots
      roots.each do |root|
        _opts = opts.merge({:node => root, :root => true, :level => opts[:level].next})
        result << sortable_tree_builder(tree, _opts)
      end
    else
      res = ''
      controls = ''
      children_res = ''

      # select children
      childs = tree.select{|elem| elem.parent_id == node.id}
      opts.merge!({:has_children => childs.blank?})

      # render childs
      childs.each do |elem|
        _opts = opts.merge({:node => elem, :root => false, :level => opts[:level].next})
        children_res << sortable_tree_builder(tree, _opts)
      end

      # build views
      children_res = children_res.blank? ? '' : render(:partial => "#{opts[:path]}/nested_set", :locals => {:opts => opts, :parent => node, :childs => children_res})
      link = render(:partial => "#{opts[:path]}/link",  :locals => {:opts => opts, :node => node, :root => root})
      res  = render(:partial => "#{opts[:path]}/item",  :locals => {:opts => opts, :node => node, :link => link, :childs => children_res})

      # delete current node from tree if you want
      # recursively moving by tree is 25%+ faster on 500 elems
      # remove from Array, not from DB! ;) ?! Array#pull?!
      # tree.delete(node) if opts[:clean]

      result << res
    end
    raw result
  end# sortable_tree_builder
end# module