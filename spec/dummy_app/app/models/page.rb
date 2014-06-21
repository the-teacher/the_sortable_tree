class Page < ActiveRecord::Base
  # Supported variants

  # Set Type of required App in config/application.rb
  if TheSortableTreeTest.app_type == 'nested_set'
    acts_as_nested_set
    include TheSortableTree::NestedSet::Rails4
  end

  # OR
  if TheSortableTreeTest.app_type == 'ancestry'
    has_ancestry
    include TheSortableTree::Ancestry::Base
  end

  # OR
  if TheSortableTreeTest.app_type == 'ancestry_acts_as_list'
    has_ancestry
    acts_as_list scope: [:ancestry]
    include TheSortableTree::Ancestry::ActsAsList
  end
end
