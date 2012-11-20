module CommentsTreeRenderHelper
  class Render
    def initialize context, options = {}
      @h       = context
      @context = context
      @options = options
    end

    # RENDER METHODS
    # USE @h (helper), for View Helpers call
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
      "<h4>#{ @h.link_to(node.title, node) } | #{ @h.url_for(ns + [node]) }</h4>"
    end

    def children
      unless @options[:children].blank?
        "<ol class='nested_set'>#{@options[:children]}</ol>"
      end
    end

  end
end