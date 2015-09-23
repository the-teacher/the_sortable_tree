require "the_sortable_tree/backends/awesome_nested_set"
require "the_sortable_tree/backends/ancestry"
require "the_sortable_tree/backends/ancestry_acts_as_list"

module TheSortableTree::Backends
  # Returns sortable tree backend.
  def self.detect(cls)
    if cls.respond_to? :quoted_parent_column_name
      return TheSortableTree::Backends::AwesomeNestedSet

    elsif cls.respond_to? :sort_by_ancestry and cls.method_defined? :acts_as_list_class
      return TheSortableTree::Backends::AncestryActsAsList

    elsif cls.respond_to? :sort_by_ancestry
      return TheSortableTree::Backends::Ancestry

    else
      Rails.logger.error "[TheSortableTree] ERROR: could not detect either awesome_nested_set or ancestry on model"
      return nil
    end
  end
end
