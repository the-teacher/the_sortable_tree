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
      end
    end
  end
end
