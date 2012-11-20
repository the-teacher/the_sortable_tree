module TreeRenderHelper
  def render_tree_node options = {}
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

  def show_link options = {}
    node = options[:node]
    ns   = options[:opts][:namespace]
    "<h4>#{ link_to(node.title, node) } | #{ url_for(ns + [node]) }</h4>"
  end

  def children options = {}
    unless options[:children].empty?
      "<ol class='nested_set'>#{options[:children]}</ol>"
    end
  end
end