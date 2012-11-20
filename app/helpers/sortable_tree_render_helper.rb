module SortableTreeRenderHelper
  class Render < TreeRender::Base
    # RENDER METHODS
    # USE h (helper), for View Helpers call
    # h.html_escape(node.content) - escape potentially dangerous content
    # USE option FOR wor with global options
    def render_node
      edit_path      = '#'
      delete_confirm = 'delete'
      edit_title     = 'edit title'
      delete_title   = 'delete title'
      node           = options[:node]

      "
        <li id='#{ node.id }_#{ options[:klass] }'>
          <div class='item'>
            <i class='handle'></i>
            #{ show_link }
            <p>#{ h.html_escape node.content }</p>
            #{ controls }
          </div>
          #{ children }
        </li>
      "
    end

    def show_link
      base_path = '#'
      "<h4><a href='#{base_path}'>#{ options[:node].title }</a></h4>"
    end

    def controls
      "<p>CONTROLS</p>"
    end

    def children
      "<ol class='nested_set'>#{ options[:children] }</ol>" unless options[:children].blank?
    end
  end
end