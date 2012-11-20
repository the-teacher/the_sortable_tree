module SortableTreeRenderHelper
  def render_sortable_tree_node options = {}
    node = options[:node]
    "
      <li>
        <div class='item'>
          #{ show_link(options) }
          <p>#{ node.title }</p>
        </div>
        #{ children(options) }
      </li>
    "
  end

  # I cant use this name of method again
  def children options = {}
  end
end