module RenderSelectOptionsHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]
        selected = (options[:selected] == node) ? ' selected' : nil
        value_property = options[:title] || :title

        "
        <option value='#{node[:id]}' class='l_#{ options[:level] }#{selected}'>#{ node[value_property] }</option>
        #{ options[:children] }
        "
      end

    end
  end
end