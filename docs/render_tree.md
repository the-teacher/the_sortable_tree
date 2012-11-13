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
    get  :manage
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
= build_tree @pages
```