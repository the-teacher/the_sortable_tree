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
          <li class='tst_tree-item'>
            <div class='tst_tree-item_content'>
              #{ show_link }
            </div>
            #{ children }
          </li>
        "
      end

      def show_link
        node = options[:node]
        url = h.url_for(:controller => kontroller, :action => :show, :id => node)
        title_field = options[:title]
        klass = 'tst_tree-link'

        "<h4>#{ h.link_to(node.send(title_field), url, class: klass) }</h4>"
      end

      def children
        unless options[:children].blank?
          "<ol class='tst_tree-list'>#{ options[:children] }</ol>"
        end
      end

      def kontroller
        options[:controller] ||= options[:klass].pluralize
      end

    end
  end
end
