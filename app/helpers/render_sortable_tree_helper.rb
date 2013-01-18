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
module RenderSortableTreeHelper
  module Render 
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]

        "
          <li id='#{ node.id }_#{ options[:klass] }'>
            <div class='item'>
              <i class='handle'></i>
              #{ show_link }
              #{ controls }
            </div>
            #{ children }
          </li>
        "
      end

      def show_link
        node = options[:node]
        ns   = options[:opts][:namespace]
        url  = h.url_for(ns + [node])
        title_field = options[:opts][:title]

        "<h4>#{ h.link_to(node.send(title_field), url) }</h4>"
      end

      def controls
        node = options[:node]
        opts = options[:opts]

        edit_path = h.url_for(:controller => opts[:klass].pluralize, :action => :edit, :id => node)
        show_path = h.url_for(:controller => opts[:klass].pluralize, :action => :show, :id => node)

        "
          <div class='controls'>
            #{ h.link_to '', edit_path, class: :edit }
            #{ h.link_to '', show_path, class: :delete, data: { confirm: 'Are you sure?' } }
          </div>
        "
      end

      def children
        unless options[:children].blank?
          "<ol class='nested_set'>#{ options[:children] }</ol>"
        end
      end

    end
  end
end