# include TheSortableTree::NestedSet::Rails3
# include TheSortableTree::NestedSet::Rails4
module TheSortableTree
  module CheckType
    extend ActiveSupport::Concern

    module ClassMethods
      def sortable_tree_type? type
        sortable_tree_type.to_s == type.to_s
      end
    end
  end

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

    module Rails4
      extend ActiveSupport::Concern

      module ClassMethods
        def sortable_tree_type; :nested_set; end
      end

      included do
        include TheSortableTree::CheckType

        scope :nested_set, lambda { order('lft ASC') }
        scope :reversed_nested_set, lambda { order('lft DESC') }
      end
    end
  end
end
