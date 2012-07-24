### TheSortableTree 

Awesome Helper for building sortable nested sets

[TheSortableTree on RubyGems](http://rubygems.org/gems/the_sortable_tree)

### Keywords

Sortable awesom_nested_set, Drag&Drop GUI for awesom_nested_set, View Helper for nested set, Nested Comments

### Description

**sortable_tree** - recursive helper-method for rendering sortable awesome_nested_set tree.

**sortable_tree** uses partials for rendering, that's why it is **so easy to customize**!

### Capabilities

**Just Tree [default or tree option]**

![TheSortableTree](https://github.com/the-teacher/the_sortable_tree/raw/master/pic_min.jpg)

**Drag&Drop Sortable Tree [sortable option]**

![TheSortableTree](https://github.com/the-teacher/the_sortable_tree/raw/master/pic.jpg)

**Comments Tree [__comments__ option]**

With New Comment form and reply functionality

![TheSortableTree](https://github.com/the-teacher/the_sortable_tree/raw/dev/comments.gif)

### LiveDemo and App for testcase creating

https://github.com/the-teacher/the_sortable_tree_test_app

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

  <%= javascript_include_tag 'sortable/base' %>
  <%= javascript_include_tag 'comments/base' %>

  <%= stylesheet_link_tag    'tree',          :media => :all %>
  <%= stylesheet_link_tag    'sortable',      :media => :all %>
  <%= stylesheet_link_tag    'comments_tree', :media => :all %>
```

### Or, if you're using Asset Pipeline

In JS manifest file (application.js):

``` js
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.ui.nestedSortable
//= require sortable/base
//= require comments/base
//= require_tree .
```

In CSS manifest file (application.css):

``` css
/*
*= require_self
*= require_tree .
*= require tree
*= require sortable
*= require comments_tree
*/

```

### Render your tree

``` ruby
= sortable_tree @pages
```

### Render your sortable tree

``` ruby
= sortable_tree @pages, :type => :sortable, :new_url => new_page_path, :max_levels => 4
```

### Render your comments tree (with New Form and Reply)

Plz, read **Comments Doc** before using this

``` ruby
= sortable_tree @comments, :type => :comments, :title => :name
```

### Comments Doc

My comment Model looks like this:

``` ruby
create_table :comments do |t|
  t.string :name
  t.string :email

  t.text   :raw_content
  t.text   :content
end
```

For me is very important to have 2 fields for **content**.

**raw_content** is unsecure raw content from user (this name using in new comment form).

**content** is prepared content once passed by content filters (Textile, Sanitize and others). This field using for rendering.

There is base example of my Comment Model.

``` ruby
class Comment < ActiveRecord::Base
  acts_as_nested_set
  include TheSortableTree::Scopes
  before_save :prepare_content

  private

  def prepare_content
    # Any content filters here
    self.content = "<b>#{self.raw_content}</b>"
  end
end
```

Plz, read **Comments Options** for modify Render Helper for your purposes.

If you have Model like this:

``` ruby
create_table :comments do |t|
  t.string :topic
  t.string :contacts
  t.text   :content
end
```

You can call helper with next params:

``` ruby
= sortable_tree @comments, :type => :comments, :title => :topic, :contacts_field => :contacts, :raw_content_field => :content, :content_field => :content
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

And render with partials from **comments/comments/base**

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
= sortable_tree @pages
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

How can I render a **select/options** menu in form? Should I use TheSortableTree?

No. You should not. TheSortableTree is helper for building composite interfaces. Simple dropdown menu can be rendering with Awesome Nested Set Helper **sorted_nested_set_options**

There is Example:

```ruby
- sorted_nested_set_options(Catalog, lambda{ |catalog| catalog.lft }) do |catalog, level|
  - options << content_tag(:option, catalog.title, :value => catalog.id, :class => "level_#{level}")

= f.select :catalog_id, options, {}
```

### Comments Options

**node_id** - comment's id which should be set as value of hidden field **parend_id** when Reply link pressed (**:id** by default)

**contacts_field** - **:email** field by default. If you want to hide contacts field - you should use customization by view generators

**content_field** - field with prepared comment's content (**:content** by default)

**raw_content_field** - field with raw comment's content (**:raw_content** by default, you can set it to **:content**)

### Common Options

**id** - id field (**:id** by default)

**title** - title field of node (**:title** by default)

**path** - path to custom view partials (:path => 'pages/sortable/tree')

**max_levels** - count of draggable levels or **max reply level** in comments tree. (**3** by default). **Can't be 0 (zero) and negative**

**namespace** - namespace for admin sections for example. (**nil** by default)

**opts[:level]** - view helper define level of recursion for each node. You can call **opts[:level]** into view partials

### Base partial's descriptions

**_tree** - root container for nested set elements

**_node** - element of tree (link to current node and nested set of children)

**_link** - decoration of link to current element of tree

**_children** - decoration of children

**_new** - create new element link

**_controls** - control elements for current node

### Can I use gem with Rails 2 or Rails 3.0?

There is no strong dependencies for Rails 3.

Take files from the gem and put it in your Rails 2 application.

And fix errors :) Ha-Ha-Ha! You can ask me if you will do it.

### Changelog

1.9.4 - rm CoffeeScript document scope, ru locale, fix data-confirm

1.9.3 - Jeffery Utter patch for coffee script

1.9.2 - View Generators updated

1.9.1 - Rewrite with coffee => **assets/javascripts/sortable/base.js.coffee**

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

### Can it be faster?

Perhaps. Read next idea to learn more. There is no implementation now, sorry.

https://github.com/the-teacher/the_sortable_tree/issues/milestones?with_issues=no

### ERB vs HAML vs SLIM

HAML by default. You can use any Template Engine, but convert partials by yourself, plz.

### Contributors

* https://github.com/the-teacher
* https://github.com/winescout
* https://github.com/gbrain
* https://github.com/Mik-die

### Acknowledgments

* https://github.com/mjsarfatti/nestedSortable
* http://iconza.com

### TheSortableTree v2.0 API (not for use, under development)

```ruby
# select tag, build at server side
= render_tree @pages, :type => :select



# just tree, build at server side
= render_tree @pages

# just tree, build at client side
= render_tree @pages, :side => :client



# sortable tree, build at server side
= render_tree @pages, :type => :sortable

# sortable tree, build at client side
= render_tree @pages, :type => :sortable, :side => :client



# comments tree, build at server side
= render_tree @pages, :type => :comments

# comments tree, build at client side
= render_tree @pages, :type => :comments, :side => :client



type
  tree
  select
  sortable
  comments

side
  client
  server

async
  true
  false

common opts
  id
  path
  title
  namespace
  max_levels
  
comments  
  node_id
  content_field
  contacts_field
  raw_content_field
```