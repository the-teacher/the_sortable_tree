require "the_sortable_tree/engine"
require "the_sortable_tree/version"

# include TheSortableTree::Scopes
module TheSortableTree
  module Scopes
    def self.included(base)
      base.class_eval do
        if Rails::VERSION::MAJOR == 3
          scope :nested_set,          order('lft ASC')
          scope :reversed_nested_set, order('lft DESC')
        elsif Rails::VERSION::MAJOR >= 4
          scope :nested_set,          lambda { order('lft ASC')  }
          scope :reversed_nested_set, lambda { order('lft DESC') }
        else
          puts "[TheSortableTree] ERROR: required Rails 3 or Rails 4"
        end
      end
    end
  end
end
