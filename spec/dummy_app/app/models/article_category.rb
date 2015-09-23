class ArticleCategory < ActiveRecord::Base
  include TheTreeModel # acts_as_nested_set or has_ancestry
  include TheSortableTree::Scopes
end
