module RenderIndentedOptionsHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]
        spacing = (options[:spacing] || 3).to_i

        html_options = {value: node.id}
        if options[:selected] == node
          html_options[:selected] = 'selected'
          html_options[:class] = 'selected'
        end
        title = "\u202f" * spacing * (options[:level]-1) + node.send(options[:title])

        h.content_tag(:option, title, html_options) + options[:children].html_safe
      end

    end
  end
end
