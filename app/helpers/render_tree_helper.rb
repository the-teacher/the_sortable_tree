# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderTreeHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]
        "
          <li>
            <div class='item'>
              #{ show_link }
            </div>
            #{ children }
          </li>
        "
      end

      def show_link
        node = options[:node]
        ns   = options[:namespace]
        url  = h.url_for(ns + [node])
        title_field = options[:title]

        "<h4>#{ h.link_to(node.send(title_field), url) }</h4>"
      end

      def children
        unless options[:children].blank?
          "<ol>#{ options[:children] }</ol>"
        end
      end

    end
  end
end