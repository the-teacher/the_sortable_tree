# include TheSortableTree::Ancestry::Base
module TheSortableTree
  module Ancestry
    module Base
      extend ActiveSupport::Concern

      module ClassMethods
        def sortable_tree_type; :ancestry; end
      end

      included do
        include TheSortableTree::CheckType

        scope :nested_set, lambda { order('ancestry ASC, id ASC') }
        scope :reversed_nested_set, lambda { nested_set.reverse_order }

        def move_to_child_of(parent)
          self.update_column :parent_id, parent.id
        end

        # ancestry has no order (other than id), only care about nesting here

        def move_to_right_of(other)
          self.update_column :parent_id, other.parent_id
        end

        def move_to_left_of(other)
          self.update_column :parent_id, other.parent_id
        end
      end
    end
  end
end
