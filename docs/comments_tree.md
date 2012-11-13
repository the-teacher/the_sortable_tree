## Render comments tree for Page Model

### Jquery and Javascripts

**app/assets/javascripts/application.js**

```ruby
//= require jquery
//= require jquery-ui
```

```ruby
//= require 'render_tree_helper'
//= require 'comments/render_node'
//= require 'comments/initializer'
```

### Stylesheets

**app/assets/stylesheets/application.css**

```ruby
//= require 'comments_tree'
```

### Routes for pages

``` ruby
resources :pages
```

**manage** action or any else action for show sortable tree

### Extend your Models

``` ruby
class Comment < ActiveRecord::Base
  include TheSortableTree::Scopes
  belongs_to :page
  
  # any code here
end

class Page
  has_many :comments

  # any code here
end
```

### Extend your Controller and Find your tree

``` ruby
class PagesController < ApplicationController
  # required only for sortable tree
  # include TheSortableTreeController::Rebuild

  def show
    @page     = Page.find params[:id]

    # IMPORTANT! Select only required fields
    @comments = @page.comments.nested_set.select('id, name, content, parent_id').all
  end

  # any code here
end
```

### Render Your Comments Tree!

```ruby
= render_tree @comments, type: :comments
```

## If you need to render reversed tree

Select your tree with **reversed_nested_set** scope

``` ruby
class PagesController < ApplicationController
  # required only for sortable tree
  # include TheSortableTreeController::Rebuild

  def manage
    @page     = Page.find params[:id]

    # IMPORTANT! Select only required fields
    @comments = @page.comments.nested_set.select('id, name, content, parent_id').all
  end

  # any code here
end
```