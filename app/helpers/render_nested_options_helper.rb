module RenderNestedOptionsHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]
        selected = (options[:selected] == node) ? ' selected' : nil

        "
        <option value='#{node[:id]}' class='l_#{ options[:level] }#{selected}'>#{ node.send(options[:title]) }</option>
        #{ options[:children] }
        "
      end

    end
  end
end