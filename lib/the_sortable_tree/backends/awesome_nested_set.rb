module TheSortableTree
  module Backends
    module AwesomeNestedSet
      def self.included(base) # :nodoc:
        base.class_eval do
          self.the_sortable_tree_sort_order = 'lft'
        end
      end
    end
  end
end

