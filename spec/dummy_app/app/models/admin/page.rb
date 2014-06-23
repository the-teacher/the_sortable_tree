class Admin::Page < ActiveRecord::Base
  # rails s
  # rails s SORTABLE_TREE_TYPE=ancestry
  # rails s SORTABLE_TREE_TYPE=ancestry_acts_as_list
  include AppTypeSelector
end
