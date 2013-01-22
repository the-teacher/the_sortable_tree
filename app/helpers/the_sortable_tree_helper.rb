module TheSortableTreeHelper
  # Publicated by MIT
  # Nested Set View Helper

  # Ilya Zykin, zykin-ilya@ya.ru, Russia [Ivanovo, Saint Petersburg] 2009-2013
  # github.com/the-teacher

  # Default renderers
  TREE_RENDERERS = {
    :tree     => RenderTreeHelper,
    :sortable => RenderSortableTreeHelper,
    :nested_options => RenderNestedOptionsHelper
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
    render_module::Render::render_node(self, options)
  end

  ###############################################
  # Shortcuts
  ###############################################
  
  def just_tree tree, options = {}
    build_server_tree(tree, { :type => :tree }.merge!(options))
  end

  def sortable_tree tree, options = {}
    build_server_tree(tree, { :type => :sortable }.merge!(options))
  end

  def nested_options tree, options = {}
    build_server_tree(tree, { :type => :nested_options }.merge!(options))
  end

  ###############################################
  # Server Side Render Tree Helper
  ###############################################

  def build_server_tree(tree, options= {})
    result = ''
    tree   = Array.wrap tree
    opts   = {
      # node and base node params
      :id    => :id,      # node id field
      :title => :title,   # name of title fileld
      :node  => nil,      # node
      # base options
      :type  => :tree,    # tree type
      :root  => false,    # is it root node?
      :level => 0,        # recursion level
      :namespace => [],   # :admin
      # SYSTEM boost array
      :boost => []       # BOOST! array
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
    # solution of main perfomance problem
    # magick index-array, which made me happy!
    if opts[:boost].empty?
      tree.each do |item|
        num = item.parent_id || 0
        opts[:boost][num] = [] unless opts[:boost][num]
        opts[:boost][num].push item
      end
    end

    unless node
      # RENDER ROOTS
      roots = opts[:boost][0]

      # define roots, if it's need
      if roots.nil? && !tree.empty?
        min_parent_id = tree.map(&:parent_id).compact.min
        roots = tree.select{ |elem| elem.parent_id == min_parent_id }
      end

      # children rendering
      if roots
        roots.each do |root|
          _opts  =  opts.merge({ :node => root, :root => true, :level => opts[:level].next, :boost => opts[:boost] })
          result << build_server_tree(tree, _opts)
        end
      end
    else
      # RENDER NODE'S CHILDREN
      children_res = ''
      children     = opts[:boost][node.id]
      opts.merge!({ :has_children => children.blank? })

      unless children.nil?
        children.each do |elem|
          _opts        =  opts.merge({ :node => elem, :root => false, :level => opts[:level].next, :boost => opts[:boost] })
          children_res << build_server_tree(tree, _opts)
        end
      end

      result << build_tree_html(self, opts[:render_module], opts.merge({ :root => root, :node => node, :children => children_res }))
    end

    raw result
  end
end