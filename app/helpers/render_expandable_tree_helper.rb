# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderExpandableTreeHelper
  module Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options
        node = options[:node]

        "
          <li data-node-id='#{ node.id }'>
            <div class='item'>
              <i class='handle'></i>
              <b class='expand plus'>+</b>
              #{ show_link }
              #{ controls }
            </div>
            #{ children }
          </li>
        "
      end

      def show_link
        node = options[:node]
        url = h.url_for(:namespace => options[:namespace], :controller => kontroller, :action => :show, :id => node)
        title_field = options[:title]

        "<h4>#{ h.link_to(node.send(title_field), url) }</h4>"
      end

      def controls
        node = options[:node]

        edit_path = h.url_for(:namespace => options[:namespace], :controller => kontroller, :action => :edit, :id => node)
        destroy_path = h.url_for(:namespace => options[:namespace], :controller => kontroller, :action => :destroy, :id => node)

        "
          <div class='controls'>
            #{ h.link_to '', edit_path, :class => :edit }
            #{ h.link_to '', destroy_path, :class => :delete, :method => :delete, :data => { :confirm => 'Are you sure?' } }
          </div>
        "
      end

      def children
        unless options[:children].blank?
          "<ol class='nested_set'>#{ options[:children] }</ol>"
        end
      end

      def kontroller
        options[:controller] ||= options[:klass].pluralize
      end

    end
  end
end
