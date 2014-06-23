module TheSortableTree
  module CheckType
    extend ActiveSupport::Concern

    module ClassMethods
      def sortable_tree_type? type
        sortable_tree_type.to_s == type.to_s
      end
    end
  end
end
