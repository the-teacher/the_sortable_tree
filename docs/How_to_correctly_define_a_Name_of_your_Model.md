## Gem can't correctly define a Name of your Model

Sometimes gem can't to define correct name of sortable model in controller.

To solve this problem you can use special methods of controller:

1. **sortable_model**
2. **sortable_collection**

For example you can write something like this:

```ruby
class ManagersPagesController < ApplicationController
  include TheSortableTreeController::Rebuild

  def manage
    @pages = Page.nested_set.select('id, title, content, parent_id').all
  end

  protected

  def sortable_model
    Page
  end

  def sortable_collection
    "pages"
  end

  # any code here
end
```