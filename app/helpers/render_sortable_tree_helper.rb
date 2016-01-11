# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderSortableTreeHelper
  module Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options
        node = options[:node]

        "
          <li data-node-id='#{ node.id }'>
            <div class='ptz--table w100p the-sortable-tree--item ptz--div-0 p5'>
              <div class='ptz--tr'>
                <div class='ptz--td vam w30'>
                  #{ handler }
                </div>

                <div class='ptz--td vam'>
                  #{ show_link }
                </div>

                <div class='ptz--td vam br-off w10 pr5'>
                  #{ controls }
                </div>
              </div>
            </div>

            #{ children }
          </li>
        "
      end

      def handler
        "<div class='the-sortable-tree--handler p5'>
          <i class='fa fa-arrows fs16'></i>
        </div>"
      end

      def show_link
        node = options[:node]
        ns   = options[:namespace]
        url = h.url_for(:controller => options[:klass].pluralize, :action => :show, :id => node)
        title_field = options[:title]

        "<div class='fs15'>
          #{ h.link_to(node.send(title_field), url) }
        </div>"
      end

      def controls
        node = options[:node]

        edit_path = h.url_for(:controller => options[:klass].pluralize, :action => :edit, :id => node)
        destroy_path = h.url_for(:controller => options[:klass].pluralize, :action => :destroy, :id => node)

        "
          <a href='#{ edit_path }'>
            <i class='fa fa-edit fs20'></i>
          </a>
        "
      end

      def children
        unless options[:children].blank?
          "<ol class='the-sortable-tree--nested-set'>#{ options[:children] }</ol>"
        end
      end

    end
  end
end
