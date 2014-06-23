# include TheSortableTree::NestedSet::Rails3
module TheSortableTree
  module NestedSet
    module Rails3
      extend ActiveSupport::Concern

      module ClassMethods
        def sortable_tree_type; :nested_set; end
      end

      included do
        include TheSortableTree::CheckType

        scope :nested_set, order('lft ASC')
        scope :reversed_nested_set, order('lft DESC')
      end
    end
  end
end
