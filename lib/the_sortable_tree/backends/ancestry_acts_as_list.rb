module TheSortableTree
  module Backends
    # @see https://github.com/stefankroes/ancestry/wiki/Integrating-with-acts_as_list
    module AncestryActsAsList
      def self.included(base) # :nodoc:
        base.class_eval do

          # @todo get from #position_column
          self.the_sortable_tree_sort_order = 'ancestry, position'

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
end
