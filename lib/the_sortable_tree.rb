require 'rails'
require 'the_sortable_tree/version'

module TheSortableTree
  class Engine < Rails::Engine; end
end

# Loading of concerns
_root_ = File.expand_path('../../', __FILE__)

%w[ nested_set ancestry ].each do |concern|
  require "#{ _root_ }/app/models/concerns/#{ concern }.rb"
end
