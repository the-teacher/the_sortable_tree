# include AppTypeSelector
module AppTypeSelector
  extend ActiveSupport::Concern

  included do
    # rails s
    # SORTABLE_TREE_TYPE=ancestry rails s
    # SORTABLE_TREE_TYPE=ancestry_acts_as_list rails s
    #
    # You will see puts in `rails concole` on first model loading
    case ENV['SORTABLE_TREE_TYPE']
      when 'ancestry'
        puts "#{ to_s } is Ancestry Model"
        has_ancestry
        include TheSortableTree::Ancestry::Base
      when 'ancestry_acts_as_list'
        puts "#{ to_s } is AncestryActsAsList Model"
        has_ancestry
        acts_as_list scope: [:ancestry]
        include TheSortableTree::Ancestry::ActsAsList
      else
        puts "#{ to_s } is NestedSet Model"
        acts_as_nested_set
        include TheSortableTree::NestedSet::Base
    end
  end
end
