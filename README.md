## TheSortableTree v2.0 (beta)

Best and Fastest **Rails 3** Helper for tree rendering (JS/Client side way)

[TheSortableTree on RubyGems](http://rubygems.org/gems/the_sortable_tree)

## Install

Gemfile

```ruby
gem 'awesome_nested_set' # or any similar gem
gem 'the_sortable_tree'
```

Console

```ruby
bundle
```

## Description

**build_tree** - JavaScript (CoffeeScript) client side recursive helper-method for rendering nested set trees for Ruby and Rails.

**build_tree** use native CoffeeScript template way for tree building. That why it is so easy to customize!

![TheSortableTree](https://github.com/the-teacher/the_sortable_tree/raw/master/docs/sortable_tree.jpg)

## Keywords

Awesome nested set, Nested set, Ruby, Rails, Nested set view helper, Sortable nested set, Drag&Drop GUI for nested set, View helper for nested set, render tree

## Basics

* [Performance](https://github.com/the-teacher/the_sortable_tree#performance)
* [Install with Rails 3](https://github.com/the-teacher/the_sortable_tree#install)
* [Supported Nested Tree Gems](https://github.com/the-teacher/the_sortable_tree#supported-nested-set-gems)

## Using

* [Simple tree rendering](https://github.com/the-teacher/the_sortable_tree/blob/master/docs/render_tree.md)
* [Sortable tree (Drag&Drop GUI) rendering](https://github.com/the-teacher/the_sortable_tree/blob/master/docs/sortable_tree.md)
* [Comments tree rendering](https://github.com/the-teacher/the_sortable_tree/blob/master/docs/comments_tree.md)
* Expandable tree (uploading parts of tree via AJAX) **(planned)**

## Customization

* [View generator](https://github.com/the-teacher/the_sortable_tree/blob/master/docs/view_generator.md)

## I want to know more

* [How gem works?](https://github.com/the-teacher/the_sortable_tree/blob/master/docs/how_gem_works.md)
* [Security notes!!!](https://github.com/the-teacher/the_sortable_tree/blob/master/docs/security_notes.md)
* [Show me Demo Application!](https://github.com/the-teacher/the_sortable_tree/blob/master/docs/the_sortable_tree_test_app.md)
* [Troubleshooting](https://github.com/the-teacher/the_sortable_tree/blob/master/docs/security_notes.md)

## Performance

It's amazing! **More than 2000 nodes per second!!!**

Just look to benchmark:

* 3 level deep
* 25 nodes per level
* 16275 nodes in tree
* Server rendering: 4906.3ms *(converting to JSON)*
* Client rendering: 3056ms *(rendering and append to DOM)*
* Performance: 16275 / 7962 = 2045 nodes/second

## Supported nested set gems

* [gem 'awesome_nested_set'](https://github.com/collectiveidea/awesome_nested_set)
* [gem 'nested_set'](https://github.com/skyeagle/nested_set)
* gem 'acts_as_ordered_tree' **(planned)**

### The MIT License (MIT)

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