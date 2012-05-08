### TheSortableTree

Awesome Helper for building sortable nested sets

### Keywords

Sortable awesom_nested_set, View Helper for nested set, Nested Comments

### Description

**sortable_tree** - recursive helper-method for rendering sortable awesome_nested_set tree.

**sortable_tree** uses partials for rendering, that's why it is **so easy to customize**!

### Capabilities

**Just Tree [default or tree option)**

![TheSortableTree](https://github.com/the-teacher/the_sortable_tree/raw/master/pic_min.jpg)

**Drag&Drop Sortable Tree [sortable option]**

![TheSortableTree](https://github.com/the-teacher/the_sortable_tree/raw/master/pic.jpg)

**Comments Tree [__comments__ option]**

With New Comment form and reply functionality

![TheSortableTree](https://github.com/the-teacher/the_sortable_tree/raw/dev/comments.gif)

### Can I use gem with Rails 2 or Rails 3.0?

There is no strong dependencies for Rails 3.

Take files from the gem and put it in your Rails 2 application.

And fix errors :) Ha-Ha-Ha! You can ask me if you will do it.

### Changelog

1.9.0 - 1) Comments tree with sand form and reply fu! 2) Way to manual set sortable Model klass into controller.

1.8.6 - fixed CamelCase names definition (by andisthejackass)

1.8.5 - helper can rendering a part tree

1.8.0 - stable release

### Is it fast?

Hmmmm...

* Development env
* 584 elements
* 3 levels deep

Rendered by 50 sec.

I think it is good result for rendering by partials.

### It's can be faster?

Perhaps. Read next idea to learn more. There is no implementation now, sorry.

https://github.com/the-teacher/the_sortable_tree/issues/milestones?with_issues=no

### ERB vs HAML vs SLIM

HAML by default. You can use any Template Engine, but convert partials by yourself, plz.

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

### Extend your Layout (erb)

``` ruby
  <%= stylesheet_link_tag    "application" %>
  <%= javascript_include_tag "application" %>
  <%= csrf_meta_tags %>

  <%= javascript_include_tag 'jquery.ui.nestedSortable' %>
  <%= javascript_include_tag 'comments_tree' %>

  <%= stylesheet_link_tag    'tree',          :media => :all %>
  <%= stylesheet_link_tag    'sortable',      :media => :all %>
  <%= stylesheet_link_tag    'comments_tree', :media => :all %>
```


### Render your tree

``` ruby
= sortable_tree @pages, :new_url => new_page_path, :max_levels => 4
```

### Render your sortable tree

``` ruby
= sortable_tree @pages, :new_url => new_page_path, :type => :sortable
```

### Render your comments tree (with New Form and Reply)

``` ruby
= sortable_tree @comments, :title => :name, :type => :comments
```

### Customization

TheSortableTree view generator will copy a set of partials from gem to your View directory.

``` ruby
rails g the_sortable_tree:views Model [option]
```

## Examples

### Customize your tree

``` ruby
rails g the_sortable_tree:views Page
```

### Customize your sortable tree

``` ruby
rails g the_sortable_tree:views Page sortable
```

### Customize your comments tree

``` ruby
rails g the_sortable_tree:views Comment comments
```

### Rendering a part of tree

``` ruby
@root  = Page.root
@pages = @root.descendants.nested_set.all
```

``` ruby
= @root.inspect
= sortable_tree @pages, :new_url => new_page_path
```

### LiveDemo

https://github.com/the-teacher/the_sortable_tree_test_app

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