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

### Extend your Controller and find your tree

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

## If you need to render reversed tree

``` ruby
class PagesController < ApplicationController
  include TheSortableTreeController::ReversedRebuild

  def manage
    @pages = Page.reversed_nested_set.select('id, title, content, parent_id').all
  end

  # any code here
end
```