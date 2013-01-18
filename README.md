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

#### Jquery and Javascripts

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

``` ruby
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

``` ruby
class Page < ActiveRecord::Base
  include TheSortableTree::Scopes
  
  # any code here
end
```

### Find your tree

``` ruby
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

# Customization

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

# I want to know more

1. [How to change HTML code of tree?](#)
2. [How to create new tree Render Helper?](#)
3. [I need to render reversed tree](#)

### Looking for maintainers

Do you want to be open source contributor? There are some ideas:

Try to create view helpers for:

1. Mongoid NestedSet
2. acts_as_ordered_tree
3. gem Ancestry (???)
4. Comments Tree gem

## The MIT License (MIT)

Copyright 2009-2012 Ilya N. Zykin (the-teacher), Mikhail Dieterle (Mik-die), Matthew Clark

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
