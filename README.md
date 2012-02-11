### TheSortableTree

Engine Based Drag&Drop GUI for awesome_nested_set gem. **Rails >= 3.1**

School teacher came to help! TaDa! ;)

**Drag&Drop sortable tree**

![TheSortableTree](https://github.com/the-teacher/the_sortable_tree/raw/master/pic.jpg)

**Simple nested sets (__min__ option)**

![TheSortableTree](https://github.com/the-teacher/the_sortable_tree/raw/master/pic_min.jpg)

**sortable_tree** - recursive helper-method for render sortable awesome_nested_set tree.

**sortable_tree** uses partials for rendering, that's why it is **so easy to customize**!

### List of available variants of rendering 

* Drag&Drop sortable tree
* Simple nested sets (**min** option)
* Nested sets with expand/collapse animation (**expand** option) [under development]
* Nested comments (**comments** option) [under development]

### Can I use gem with Rails 2 or Rails 3.0?

Take files from the gem and put it in your rails 2 application.

View helper and view files does not depend on the version of rails.

Copy and Paste rebuild function from TheSortableTreeController.

Perhaps, you may have to slightly change the function of the controller.

### Is it fast?

Hmmmm...

* Development env
* 584 elements
* 3 levels deep

Rendered by 50 sec.

I think it is good result for rendering by partials.

Can you makes it faster? Welcome!

### ERB vs HAML vs SLIM

So, ERB and SLIM fans want to make gem independent of HAML.

Ok, let it be. But you will convert view partials youself. It's my revenge ;)

Read project wiki for looking ERB partials

**By default I'm use HAML, and now you should define it manually in your Gemfile.**

### Install

    gem 'haml'
    gem 'awesome_nested_set' # gem 'nested_set'
    gem 'the_sortable_tree'

bundle

### Require

1. gem 'nested_set' or gem 'awesome_nested_set'
2. gem 'haml'
3. JQuery UI

### Example of using with Page Model

### Jquery

**app/assets/javascripts/application.js**

``` ruby
//= require jquery
//= require jquery-ui
//= require jquery_ujs
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

or (for reversed tree)

``` ruby
class PagesController < ApplicationController
  include TheSortableTreeController::ReversedRebuild
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
    @pages = Page.nested_set.all
  end

  # any code here
end

```

or 

``` ruby
class PagesController < ApplicationController
  include TheSortableTreeController::ReversedRebuild

  def manage
    @pages = Page.reversed_nested_set.all
  end
  
  # any code here
end
```

### Render your tree with TheSortableTree (Haml markup)

``` ruby
- content_for :css do
  = stylesheet_link_tag 'the_sortable_tree', :media => :screen
- content_for :js do
  = javascript_include_tag 'jquery.ui.nestedSortable'

= sortable_tree @pages, :new_url => new_page_path, :max_levels => 4
```

or (without administrator controls and drag&drop)

``` ruby
- content_for :css do
  = stylesheet_link_tag 'the_sortable_tree_min', :media => :screen

= sortable_tree @pages, :new_url => new_page_path, :path => 'the_sortable_tree_min'
```

### Customize tree for User (min version)

**Use sortable_tree as view helper for simple rendering of nested_set tree**

``` ruby
rails g the_sortable_tree:views pages min
```

It's will generate minimal set of view partials for **sortable_tree** helper

``` ruby
create  app/views/pages/the_sortable_tree_min
create  app/views/pages/the_sortable_tree_min/_children.html.haml
create  app/views/pages/the_sortable_tree_min/_node.html.haml
create  app/views/pages/the_sortable_tree_min/_link.html.haml
create  app/views/pages/the_sortable_tree_min/_tree.html.haml
```

Just use it or Customize and use it!

``` ruby
- content_for :css do
  = stylesheet_link_tag 'the_sortable_tree_min', :media => :screen
= sortable_tree @pages, :new_url => new_page_path, :path => 'pages/the_sortable_tree_min'
```

### Customize tree for Administrator (full version)

``` ruby
rails g the_sortable_tree:views pages
```

It's will generate view partials for **sortable_tree** helper

``` ruby
create  app/views/pages/the_sortable_tree
create  app/views/pages/the_sortable_tree/_controls.html.haml
create  app/views/pages/the_sortable_tree/_node.html.haml
create  app/views/pages/the_sortable_tree/_js_init_sortable_tree.html.haml
create  app/views/pages/the_sortable_tree/_js_on_update_tree.html.haml
create  app/views/pages/the_sortable_tree/_js_rebuild_ajax.html.haml
create  app/views/pages/the_sortable_tree/_link.html.haml
create  app/views/pages/the_sortable_tree/_children.html.haml
create  app/views/pages/the_sortable_tree/_new.html.haml
create  app/views/pages/the_sortable_tree/_tree.html.haml
```

Customize and use it!

``` ruby
- content_for :css do
  = stylesheet_link_tag 'the_sortable_tree', :media => :screen
- content_for :js do
  = javascript_include_tag 'jquery.ui.nestedSortable'

= sortable_tree @pages, :new_url => new_page_path, :path => 'pages/the_sortable_tree', :max_levels => 2
```

### Options

**id** - id field (:id => :friendly_id etc. **:id** by default)

**title** - title field of node (:title => :name etc. **:title** by default)

**path** - path to custom view partials (:path => 'pages/the_sortable_tree')

**max_levels** - how many draggable levels can be? (**3** by default). **Can't be 0 (zero) and negative**

**namespace** - namespace for admin sections for example. (:namespace => :admin, **:namespace** => nil by default)

**opts[:level]** - view helper define level of recursion for each node. You can call **opts[:level]** into view partials

### Partials

**_tree** - root container for nested set elements

**_node** - element of tree (link to current node and nested set of children)

**_link** - decoration of link to current element of tree

**_children** - decoration of children

**_new** - create new element link

**_controls** - control elements for current node


**_js_init_sortable_tree** - JS for sortable tree

**_js_on_update_tree**- JS for sortable tree

**_js_rebuild_ajax**- JS for sortable tree

### Contributors

* https://github.com/the-teacher
* https://github.com/winescout
* https://github.com/gbrain
* https://github.com/Mik-die

### Acknowledgments

* https://github.com/mjsarfatti/nestedSortable
* http://iconza.com