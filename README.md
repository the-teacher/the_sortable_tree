### TheSortableTree v2.0 (beta)

Best and Fastest **Rails 3** Helper for tree rendering (JS/Client side way)

[TheSortableTree on RubyGems](http://rubygems.org/gems/the_sortable_tree)

### Keywords

Awesome nested set, Nested set, Ruby, Rails, Nested set view helper, Sortable nested set, Drag&Drop GUI for nested set, View helper for nested set, render tree

### Description

**render_tree** - JavaScript (CoffeeScript) client side recursive helper-method for rendering nested set trees for Ruby and Rails.

**render_tree** use native CoffeeScript template way for tree building. That why it is so easy to customize!

### Performance

It's amazing! More than 2000 nodes per second!!!

Just look to benchmark:

* 3 level deep
* 25 nodes per level
* 16275 nodes in tree
* Server rendering: 4906.3ms
* Client rendering: 3056ms
* Performance: 16275 / 7962 = 2045 nodes/second

### Capabilities

**Just Tree [default or tree option]**

![TheSortableTree](https://github.com/the-teacher/the_sortable_tree/raw/master/pic_min.jpg)

**Drag&Drop Sortable Tree [sortable option]**

![TheSortableTree](https://github.com/the-teacher/the_sortable_tree/raw/master/pic.jpg)

**Comments Tree [__comments__ option]**

With New Comment form and basic functionality

![TheSortableTree](https://github.com/the-teacher/the_sortable_tree/raw/dev/comments.gif)

### Demo Application and Application for testcase creating

https://github.com/the-teacher/the_sortable_tree_test_app

### Install

```ruby
gem 'awesome_nested_set' # gem 'nested_set'
gem 'the_sortable_tree'
```

```ruby
bundle
```

### Example of using with Page Model

### Jquery and Javascripts

**app/assets/javascripts/application.js**

```ruby
//= require jquery
//= require jquery-ui
//= require jquery_ujs
```

```ruby
//= require 'render_tree_helper'
//= require 'tree/render_node'
//= require 'tree/initializer'
```

### Stylesheets

**app/assets/stylesheets/application.css**

```ruby
//= require 'tree'
```

### Extend your Model

``` ruby
class Page < ActiveRecord::Base
  include TheSortableTree::Scopes
  # any code here
end
```

### Extend your Controller

``` ruby
class PagesController < ApplicationController
  include TheSortableTreeController::Rebuild
  # any code here
end
```

### Extend your Routes

``` ruby
resources :pages do
  collection do
    get :manage
    post :rebuild
  end
end
```

**manage** action or any else action for show sortable tree

**rebuild** action is _required_ action for correctly work of **the_sortable_tree**

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

### Render Your Tree!

```ruby
= render_tree @pages, type: :tree
```