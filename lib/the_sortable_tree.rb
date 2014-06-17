require "the_sortable_tree/engine"
require "the_sortable_tree/version"
require "the_sortable_tree/backends"

# include TheSortableTree::Scopes
module TheSortableTree
  module Scopes
    def self.included(base)
      base.class_eval do

        cattr_accessor :the_sortable_tree_sort_order

        # Load backend
        include TheSortableTree::Backends.detect(base)

        # Define scopes
        if Rails::VERSION::MAJOR == 3
          scope :nested_set,          order(the_sortable_tree_sort_order)
          scope :reversed_nested_set, order(the_sortable_tree_sort_order).reverse_order
        elsif Rails::VERSION::MAJOR == 4
          scope :nested_set,          lambda { order(the_sortable_tree_sort_order) }
          scope :reversed_nested_set, lambda { order(the_sortable_tree_sort_order).reverse_order }
        else
          puts "[TheSortableTree] ERROR: required Rails 3 or Rails 4"
        end

      end
    end
  end
end
