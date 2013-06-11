class ArticleCategory < ActiveRecord::Base
  acts_as_nested_set
  include TheSortableTree::Scopes
  # attr_accessible :name, :parent_id
end
