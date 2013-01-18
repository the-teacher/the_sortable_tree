## How to create new tree HTML Builder helper?

Generate new Helper file

```ruby
bundle exec rails g helper my_render_tree_helper
```

Puts next template code:

```ruby
module MyRenderTreeHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        "<li>
          <ol>#{ options[:children] }</ol>
        </li>"
      end

    end
  end
end
```

**class Render** should contain **render_node(h, options)** method.

Use your tree HTML Builder helper with next way:

View file (HAML):

```haml
%ol.tree= build_server_tree @posts, render_module: MyRenderTreeHelper
```