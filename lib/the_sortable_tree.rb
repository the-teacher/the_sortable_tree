require "the_sortable_tree/engine"
require "the_sortable_tree/version"

module TheSortableTree
  # include TheSortableTree::Scopes
  module Scopes
    def self.included(base)
      base.class_eval do
        # BASIC SCOPES
        scope :nested_set,          order('lft ASC')
        scope :reversed_nested_set, order('lft DESC')
        # SELECT ONLY REQUIRED FIELDS
        scope :default_tree_fields,    select('id, title, content, parent_id')
        scope :default_comment_fields, select('id, name,  content, parent_id')
      end
    end
  end
end
