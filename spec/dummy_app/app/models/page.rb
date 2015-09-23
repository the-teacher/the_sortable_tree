class Page < ActiveRecord::Base
  include TheTreeModel # acts_as_nested_set or has_ancestry
  include TheSortableTree::Scopes
  # attr_accessible :name, :parent_id
end
