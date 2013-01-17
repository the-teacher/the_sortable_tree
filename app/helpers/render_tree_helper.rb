# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# USE h (helper), for View Helpers call
# Example: h.url_for(args) | h.link_to(args)

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content

# USE **option** method
# to get all args form TheSortableTreeHelper renderer

# BANCHMARK:
# Server Side, 16.000 nodes, 3 levels
# Views: 7999.6ms | ActiveRecord: 79.2ms
# WebInspector full time ~ 9.64s
module RenderTreeHelper
  class Render
    class << self
      def h; @context; end
      def options; @options; end

      def render_node(context, options)
        @context = context
        @options = options

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
        url  = h.url_for(ns + [node])
        "<h4>#{ h.link_to(node.title, url) }</h4>"
      end

      def children
        unless @options[:children].blank?
          "<ol class='nested_set'>#{@options[:children]}</ol>"
        end
      end
    end# self
  end# Render
end# RenderTreeHelper