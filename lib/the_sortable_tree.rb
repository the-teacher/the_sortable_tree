require 'rails'
require 'the_sortable_tree/version'

module TheSortableTree
  class Engine < Rails::Engine; end
end

# Loading of concerns
_root_ = File.expand_path('../../', __FILE__)

%w[ check_type nested_set nested_set_rails3 ancestry ancestry_acts_as_list ].each do |concern|
  require "#{ _root_ }/app/models/concerns/#{ concern }.rb"
end
