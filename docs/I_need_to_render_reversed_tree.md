## I need to render reversed tree

Sometimes we need to render reversed tree.

It's can be news feed, where oldest records should be at bottom of list (set).

TheSortableTree has **reverse** methods and scopes for reversed trees.

Just change your controller code:

``` ruby
class PagesController < ApplicationController
  include TheSortableTreeController::ReversedRebuild

  def manage
    @pages = Page.reversed_nested_set.select('id, title, content, parent_id').all
  end

  # any code here
end
```