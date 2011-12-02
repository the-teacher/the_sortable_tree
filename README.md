### TheSortableTree

GUI for nested_set gem. Rails 3+

**Engine Based**

### Install

    gem 'the_sortable_tree'

bundle

### Require

1. gem 'nested_set'
2. gem 'haml'
3. JQuery UI

### Extend you Model

``` ruby
# SCOPES FOR SORTABLE NESTED SET
scope :nested_set,          order('lft ASC')
scope :reversed_nested_set, order('lft DESC')
```

### Extend you Controller

``` ruby
include TheSortableTreeController::Rebuild
```

### Extend you Routes

``` ruby
resources :elements do
  collection do
    get :manage
    post :rebuild
  end
end
```

### Find you tree

``` ruby
def manage
  @elements = Element.all.nested_set
end
```

### Render you tree with TheSortableTree

``` ruby
- content_for :css do
  = stylesheet_link_tag 'the_sortable_tree', :media => :screen
- content_for :js do
  = javascript_include_tag 'jquery.ui.nestedSortable'

= sortable_tree @elements, :klass => :element, :rebuild_url => rebuild_elements_path
```

### Customize

``` ruby
rails g the_sortable_tree:views elements
```
