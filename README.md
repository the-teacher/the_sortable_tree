## TheSortableTree v2.0

Best render helper for Nested Set ([RubyGems](http://rubygems.org/gems/the_sortable_tree)). Very fast! **2000 nodes/sec**. Ready for rails 4

## Sortable tree. Drag&Drop GUI

![Drag&Drop GUI. Sotrable tree](https://raw.github.com/the-teacher/the_sortable_tree/master/docs/sortable.jpg)

## Render tree

![Render tree](https://raw.github.com/the-teacher/the_sortable_tree/master/docs/tree.jpg)

## Keywords

Awesome nested set, Nested set, Ruby, Rails, Nested set view helper, Sortable nested set, Drag&Drop GUI for nested set, View helper for nested set, render tree

## Install

```ruby
gem 'awesome_nested_set' # or any similar gem (gem 'nested_set')
gem 'the_sortable_tree'
```

Console

```ruby
bundle
```

## Using

#### JQuery and JavaScripts

**app/assets/javascripts/application.js**

Sortable GUI require JQuery libs

```ruby
//= require jquery
//= require jquery-ui
//= require jquery_ujs
```

Add next JS only for Sortable GUI

```ruby
//= require jquery.ui.nestedSortable
//= require sortable_tree/initializer
```

#### Stylesheets

**app/assets/stylesheets/application.css**

```ruby
*= require tree
*= require sortable_tree
```

### Extend your Routes for Sortable GUI

```ruby
resources :pages do
  collection do
    get :manage

    # required for Sortable GUI server side actions
    post :rebuild
  end
end
```

**manage** - just page, where you want render Sortable tree.

### Extend your Model

```ruby
class Page < ActiveRecord::Base
  include TheSortableTree::Scopes
  
  # any code here
end
```

### Extend your controller and find your tree

```ruby
class PagesController < ApplicationController
  include TheSortableTreeController::Rebuild

  def manage
    @pages = Page.nested_set.select('id, title, content, parent_id').all
  end

  # any code here
end
```

## Render Tree

**app/views/pages/manage.html.haml**

```haml
%ol.tree= build_server_tree @pages
```

## Render Sortable Tree

**app/views/pages/manage.html.haml**

```haml
%ol.sortable_tree{ data: { max_levels: 5, rebuild_url: rebuild_pages_url } }
  = build_server_tree @pages, type: :sortable
```

## build_server_tree options

**Client side:**

Required params for sortable GUI! Must be defined at root element of tree.

1. **max_levels** - maximum depth of nesting
2. **rebuild_url** - URL to rebuild method on server side

**Server side:**

```ruby
options[:NAME]
```

Optional params

1. **id** - id field of node
2. **title** - title field of node
3. **type** - type of tree [tree|sortable]
4. **namespace** - for example: **:admin**. **[]** - by default

**Rendering runtime params (see code of render helpers):**

You can use next options, when rendering run:

1. **level** - level number
2. **root** - root flag [true|false]
3. **klass** - class name
4. **has_children** - has children flag [true|false]

## Customization

Try to run next view generators:

Render helpers for HTML tree generation

```ruby
bundle exec rails g the_sortable_tree:views tree
bundle exec rails g the_sortable_tree:views sortable
```

Base Render helper of gem

```ruby
bundle exec rails g the_sortable_tree:views helper
```

Assets of gem

```ruby
bundle exec rails g the_sortable_tree:views assets
```

## I want to know more

1. [How to change HTML code of tree?](https://github.com/the-teacher/the_sortable_tree/blob/master/docs/How_to_change_HTML_code_of_tree.md)
2. [How to create new tree HTML Builder helper?](https://github.com/the-teacher/the_sortable_tree/blob/master/docs/How_to_create_new_tree_Render_Helper.md)
3. [I need to render reversed tree](https://github.com/the-teacher/the_sortable_tree/blob/master/docs/I_need_to_render_reversed_tree.md)
4. [Gem can't correctly define a Name of your Model](https://github.com/the-teacher/the_sortable_tree/blob/master/docs/How_to_correctly_define_a_Name_of_your_Model.md)

## Is it fast?

BANCHMARK:

- Server Side, 16.000 nodes, 3 levels
- Views: 7999.6ms | ActiveRecord: 79.2ms
- WebInspector full time ~ 9.64s

total: ~2000 nodes/sec

## Looking for maintainers

Do you want to be open source contributor? There are some ideas:

Try to create view helpers for:

1. Mongoid NestedSet
2. acts_as_ordered_tree
3. gem Ancestry (???)
4. Comments Tree gem

## The MIT License (MIT)

Copyright 2009-2013 Ilya N. Zykin (the-teacher), Mikhail Dieterle (Mik-die), Matthew Clark

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
