# include TheSortableTree::Ancestry::ActsAsList
module TheSortableTree
  module Ancestry
    module ActsAsList
      extend ActiveSupport::Concern

      module ClassMethods
        def sortable_tree_type; :ancestry_acts_as_list; end
      end

      included do
        include TheSortableTree::CheckType

        scope :nested_set, lambda { order('ancestry ASC, position ASC') }
        scope :reversed_nested_set, lambda { nested_set.reverse_order }

        # based on
        # https://github.com/stefankroes/ancestry/wiki/awesome_nested_set-like-methods-for-scriptaculous-and-acts_as_list

        def move_to_child_of(parent)
          transaction do
            remove_from_list
            self.update_attributes! parent: parent
            add_to_list_bottom
            save!
          end
        end

        def move_to_left_of(other)
          transaction do
            remove_from_list
            other.reload # things may have changed in this list
            self.update_attributes! parent_id: other.parent_id
            new_position = other.position
            increment_positions_on_lower_items(new_position)
            other.reload
            self.update_attribute :position, new_position
          end
        end

        def move_to_right_of(other)
          transaction do
            remove_from_list
            other.reload # things may have changed in this list
            self.update_attributes! parent_id: other.parent_id
            if new_position = other.lower_item.try(:position)
              increment_positions_on_lower_items(new_position)
              self.update_attribute :position, new_position
            else
              add_to_list_bottom
              save!
            end
          end
        end
      end
    end
  end
end
