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

**options** - it's hash of common options and data 
**h** - it's view context

Use your tree HTML Builder helper with next way:

View file (HAML):

```haml
%ol.tree= build_server_tree @posts, render_module: MyRenderTreeHelper
```

## h method as view context

To have access to view helpers you should to use **h** method.

for example:

```ruby
  h.link_to 'Edit page', options[:node]
```

and example of real code:

```ruby
  def render_node(h, options)
    @h, @options = h, options

    link_to_page = h.link_to 'Edit page', options[:node]

    "<li>
      <p>#{ link_to_page }</p>
      <ol>#{ options[:children] }</ol>
    </li>"
  end
```