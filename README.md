# TheSortableTree

[![Gem Version](https://badge.fury.io/rb/the_sortable_tree.png)](http://badge.fury.io/rb/the_sortable_tree) [![Code Climate](https://codeclimate.com/github/the-teacher/the_sortable_tree.png)](https://codeclimate.com/github/the-teacher/the_sortable_tree)

> tested with rails 4.1.0rc2 + haml 4

Nested Set + Drag&Drop GUI. Very fast! Best render helper! **2000 nodes/sec**. Ready for rails 4 ([RubyGems](http://rubygems.org/gems/the_sortable_tree))

### Dummy Application

* [spec/dummy_app](https://github.com/the-teacher/the_sortable_tree/tree/master/spec/dummy_app)
* [spec/dummy_app/README.md](https://github.com/the-teacher/the_sortable_tree/blob/master/spec/dummy_app/README.md)

## Sortable tree. Drag&Drop GUI

![Drag&Drop GUI. Sotrable tree](https://raw.github.com/the-teacher/the_sortable_tree/master/docs/sortable.jpg)

## Render tree

![Render tree](https://raw.github.com/the-teacher/the_sortable_tree/master/docs/tree.jpg)

## Render Nested Options

![Nested options](https://raw.github.com/the-teacher/the_sortable_tree/master/docs/nested_options.jpg)

## Expandable tree

![Expandable](https://raw.github.com/the-teacher/the_sortable_tree/master/docs/expandable.jpg)

## Keywords

Awesome nested set, Nested set, Ruby, Rails, Nested set view helper, Sortable nested set, Drag&Drop GUI for nested set, View helper for nested set, render tree

## Install

**Gemfile** (Rails 3, Rails 4)

```ruby
gem 'awesome_nested_set' # or any similar gem (gem 'nested_set')
gem "the_sortable_tree", "~> 2.5.0"
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
//= require the_sortable_tree/jquery.ui.nestedSortable
//= require the_sortable_tree/sortable_ui/base

// with Turbolinks
$ ->
  TheSortableTree.SortableUI.init()

// with Turbolinks
$(document).on "ready page:load", ->
  TheSortableTree.SortableUI.init()
```

#### Stylesheets

**app/assets/stylesheets/application.css**

```ruby
*= require tree
*= require sortable_tree
*= require nested_options

*= the_sortable_tree/sortable_ui/base
```

```
  ol.the-sortable-tree.the-sortable-tree--list(data={ max_levels: 5, rebuild_url: rebuild_hubs_url })
    = sortable_tree @hubs
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

## Basic Render Method

```ruby
build_server_tree(tree, options)
```

## Render Tree

**app/views/pages/manage.html.haml**

```haml
%ol.tree= just_tree @pages
```

**just_tree** is just alias of **build_server_tree(tree, type: :tree)**

## Render Sortable Tree

```haml
%ol.sortable_tree{ data: { max_levels: 5, rebuild_url: rebuild_pages_url } }
  = sortable_tree @pages
```
**sortable_tree** is just alias of **build_server_tree(tree, type: :sortable)**

## Render Nested Options Tree

```haml
= select_tag :page_id, nested_options(@pages, :selected => Page.last), class: :nested_options
```

**nested_options** is just alias of **build_server_tree(tree, type: :nested_options)**


## build_server_tree options

**Client side:**

Required params for sortable GUI! Must be defined at root element of tree.

1. **max_levels** - maximum depth of nesting
2. **rebuild_url** - URL to rebuild method on server side


```ruby
%ol.sortable_tree{ data: { max_levels: 3, rebuild_url: rebuild_pages_url } }
```

**Server side:**


define

```ruby
build_server_tree(pages, {:option_1 => :value_1, :option_2 => :value_2})
```

use

```ruby
options[:NAME]
```

Options list:

1. **id** - id field of node
2. **title** - title field of node
3. **type** - type of tree [tree|sortable|nested_options]
4. **namespace** - for example: **:admin**. **[]** - by default
5. **render_module** - your own Render Tree Helper

**Rendering runtime params (see code of render helpers):**

You can use next options, when rendering run:

1. **level** - level number
2. **root** - root flag [true|false]
3. **klass** - class name
4. **has_children** - has children flag [true|false]
5. **children** - array of children

## Customization

Try to run next view generators:

Render helpers for HTML tree generation

```ruby
bundle exec rails g the_sortable_tree:views tree
bundle exec rails g the_sortable_tree:views sortable
bundle exec rails g the_sortable_tree:views nested_options
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
5. [ChangeLog](https://github.com/the-teacher/the_sortable_tree/blob/master/docs/ChangeLog.md)

## Is it fast? Yes, it is!

BANCHMARK:

tree params: 16.000 nodes, 3 levels

- Views: 7999.6ms | ActiveRecord: 79.2ms
- WebInspector full time ~ 9.64s

total: ~ **2000 nodes/sec**

## Looking for maintainers

Do you want to be open source contributor? There are some ideas:

Try to create view helpers for:

1. Mongoid NestedSet
2. acts_as_ordered_tree
5. Expand tree via AJAX
4. Comments Tree gem
3. gem Ancestry (???)

## I want to try! I need tests!

1. I'm develop gem with test app [the_sortable_tree_test_app](https://github.com/the-teacher/the_sortable_tree_test_app). You can clone it and see some testcase-pages for gem
2. Sorry, but I have not tests for this gem. Gem is so simple. It's easy to test only with test app.
3. You can write some tests, if your need. I will be happy certainly.
4. No! I know RSpec. I can write tests. But I have not reasons to write tests here.

##  Аcknowledgment

1. [mjsarfatti/nestedSortable](https://github.com/mjsarfatti/nestedSortable)
2. [iconza](http://iconza.com)

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
