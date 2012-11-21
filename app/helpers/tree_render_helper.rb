module TreeRenderHelper
  class Render < TreeRender::Base
    # DOC:
    # We use Helper Methods for tree building,
    # because it's faster than View Templates and Partials

    # USE h (helper), for View Helpers call
    # Example: h.url_for(args) | h.link_to(args)

    # SECURITY note
    # Prepare your data on server side for rendering
    # or use h.html_escape(node.content)
    # for escape potentially dangerous content

    # USE option METHOD
    # to get all args form TheSortableTreeHelper renderer
    def render_node
      node = @options[:node]
      "
        <li>
          <div class='item'>
            #{ show_link }
            <p>#{ node.title }</p>
          </div>
          #{ children }
        </li>
      "
    end

    def show_link
      node = @options[:node]
      ns   = @options[:opts][:namespace]
      "<h4>#{ h.link_to(node.title, node) } | #{ h.url_for(ns + [node]) }</h4>"
    end

    def children
      unless @options[:children].blank?
        "<ol class='nested_set'>#{@options[:children]}</ol>"
      end
    end

  end
end

# h.render(:partial => "tree/tree", :locals => { })