class Inventory::Category < ActiveRecord::Base
  acts_as_nested_set
  include TheSortableTree::Scopes
end
