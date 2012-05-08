### TheSortableTree

Awesome Helper for building sortable nested sets

### Keywords

Sortable awesom_nested_set, Drag&Drop GUI for awesom_nested_set, View Helper for nested set, Nested Comments

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

### LiveDemo and App for testcase creating

https://github.com/the-teacher/the_sortable_tree_test_app

### Changelog

1.9.0 - 1) **Helper API changed!** 2) Comments tree with sand form and reply fu! 3) Way to manual set sortable Model klass into controller.

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

```ruby
bundle
```

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
= sortable_tree @pages, :new_url => new_page_path
```

### Render your sortable tree

``` ruby
= sortable_tree @pages, :new_url => new_page_path, :type => :sortable, :max_levels => 4
```

### Render your comments tree (with New Form and Reply)

Plz, read **Comments Doc** before using this

``` ruby
= sortable_tree @comments, :title => :name, :type => :comments
```

### Comments Doc

Coming soon...

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

And render with partials from **pages/tree/base**

``` ruby
= sortable_tree @pages, :path => 'pages/tree/base'
```

### Customize your sortable tree

``` ruby
rails g the_sortable_tree:views Page sortable
```

And render with partials from **pages/sortable/base**

``` ruby
= sortable_tree @pages, :path => 'pages/sortable/base', :new_url => new_page_path
```

### Customize your comments tree

``` ruby
rails g the_sortable_tree:views Comment comments
```

And render with partials from **pages/sortable/base**

``` ruby
= sortable_tree @comments, :path => 'comments/comments/base', :title => :name
```

### Troubleshooting

If you need to render a part of tree:

``` ruby
@root  = Page.root
@pages = @root.descendants.nested_set.all
```

``` ruby
= @root.inspect
= sortable_tree @pages, :new_url => new_page_path
```

If **TheSortableTree** can't correctly define a Name of your Model, just add **sortable_model** into your Controller:

``` ruby
class Inventory::CategoriesController < ApplicationController
  include TheSortableTreeController::Rebuild

  def sortable_model
    Inventory::Category
  end

  def index
    @inventory_categories = Inventory::Category.nested_set.all
  end

  def manage
    @inventory_categories = Inventory::Category.nested_set.all
  end
end
```

### Comments Options

**node_id** - comment's id which should be set as value of hidden field **parend_id** when Reply link pressed (**id** by default)
**contacts_field** - **email** field by default, **false** when contacts should be hidden
**content_field** - field with prepared comment's content (**content** by default)
**raw_content_field** - field with raw comment's content (**raw_content** by default, you can set it to **content**)

### Common Options

**id** - id field (:id => :slug etc. **:id** by default)

**title** - title field of node (:title => :name etc. **:title** by default)

**path** - path to custom view partials (:path => 'pages/sortable/tree')

**max_levels** - how many draggable levels can be or **Max Comments Reply Level** ? (**3** by default). **Can't be 0 (zero) and negative**

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