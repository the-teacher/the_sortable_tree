# include TheSortableTree::NestedSet::Base
module TheSortableTree
  module NestedSet
    module Base
      extend ActiveSupport::Concern

      module ClassMethods
        def sortable_tree_type; :nested_set; end
      end

      included do
        include TheSortableTree::CheckType

        scope :nested_set, lambda { order('lft ASC') }
        scope :reversed_nested_set, lambda { nested_set.reverse_order }
      end
    end
  end
end
