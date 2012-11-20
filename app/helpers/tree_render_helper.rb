module TreeRenderHelper
  class Render
    # BASE
    def h
      @context
    end

    def options
      @options
    end

    def initialize context, options = {}
      @context = context
      @options = options
    end
    
    # RENDER METHODS
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