module TreeRenderHelper
  def render_tree_node opts = {}
    node = opts[:node]
    "
      <li>
        <div class='item'>
          #{ show_link(opts) }
          <p>#{ node.title }</p>
        </div>
        #{ children(opts) }
      </li>
    "
  end

  def show_link opts = {}
    node = opts[:node]
    "<h4>#{ link_to(node.title, node) } | #{ url_for(opts[:namespace] + [node]) }</h4>"
  end

  def children opts = {}
    unless opts[:children].empty?
      "<ol class='nested_set'>#{opts[:children]}</ol>"
    end
  end
end