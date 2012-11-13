## Render tree of nested pages

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

### Extend your Routes

``` ruby
resources :pages do
  collection do
    get :manage

    # not required for simple tree
    # post :rebuild
  end
end
```

**manage** action or any else action for show tree

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
  # not required for simple tree
  # include TheSortableTreeController::Rebuild

  def manage
    @pages = Page.nested_set.select('id, title, content, parent_id').all
  end

  # any code here
end
```

### Render Your Tree!

```ruby
= build_tree @pages
```

## If you need to render reversed tree

Select your tree with **reversed_nested_set** scope

``` ruby
class PagesController < ApplicationController
  # not required for simple tree
  # include TheSortableTreeController::ReversedRebuild

  def manage
    @pages = Page.reversed_nested_set.select('id, title, content, parent_id').all
  end

  # any code here
end
```