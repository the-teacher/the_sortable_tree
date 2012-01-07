### TheSortableTree

Engine Based GUI for nested_set gem. Rails 3+

**sortable_tree** - recursive helper-method for render sortable nested_set tree.

**sortable_tree** uses partials for rendering, that's why it is **so easy to customize**!

### Install

    gem 'the_sortable_tree'

bundle

### Require

1. gem 'nested_set' or gem 'awesome_nested_set'
2. gem 'haml'
3. JQuery UI

### Example of using with Page Model

### Extend your Model

``` ruby
class Page < ActiveRecord::Base
  # SCOPES FOR SORTABLE NESTED SET
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

= sortable_tree @pages, :klass => :page, :rebuild_url => rebuild_pages_path
```

### Customize

``` ruby
rails g the_sortable_tree:views pages
```

It's will generate view partials for **sortable_tree** helper

``` ruby
create  app/views/pages/the_sortable_tree
create  app/views/pages/the_sortable_tree/_controls.html.haml
create  app/views/pages/the_sortable_tree/_item.html.haml
create  app/views/pages/the_sortable_tree/_js_init_sortable_tree.html.haml
create  app/views/pages/the_sortable_tree/_js_on_update_tree.html.haml
create  app/views/pages/the_sortable_tree/_js_rebuild_ajax.html.haml
create  app/views/pages/the_sortable_tree/_link.html.haml
create  app/views/pages/the_sortable_tree/_nested_set.html.haml
create  app/views/pages/the_sortable_tree/_new.html.haml
create  app/views/pages/the_sortable_tree/_tree.html.haml
```

**_tree** - root container for nested set elements

**_item** - element of tree (link to current element and childs)

**_link** - decoration of link to current element of tree

**_nested_set** - decoration of childs

**_new** - create new element link

**_controls** - control elements for current tree element


**_js_init_sortable_tree** - JS for sortable tree

**_js_on_update_tree**- JS for sortable tree

**_js_rebuild_ajax**- JS for sortable tree

Customize and use it!

``` ruby
= sortable_tree @pages, :klass => :page, :rebuild_url => rebuild_pages_path, :path => 'pages/the_sortable_tree'
```

### Acknowledgments

* https://github.com/mjsarfatti/nestedSortable
* http://iconza.com