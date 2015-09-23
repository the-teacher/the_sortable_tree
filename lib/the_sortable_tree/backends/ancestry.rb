module TheSortableTree
  module Backends
    module Ancestry
      def self.included(base) # :nodoc:
        base.class_eval do
          self.the_sortable_tree_sort_order = 'ancestry, id'

          def move_to_child_of(parent)
            self.update_attributes! parent_id: parent.id
          end

          # ancestry has no order (other than id), only care about nesting here

          def move_to_right_of(other)
            self.update_attributes! parent_id: other.parent_id
          end

          def move_to_left_of(other)
            self.update_attributes! parent_id: other.parent_id
          end
        end
      end
    end
  end
end
