require "the_sortable_tree/engine"
require "the_sortable_tree/version"

module TreeRender
  class Base
    def h
      @context
    end

    def options
      @options
    end

    def initialize context, options = {}
      @context = context
      @options = options
    end
  end
end

module TheSortableTree
  # include TheSortableTree::Scopes
  module Scopes
    def self.included(base)
      base.class_eval do
        # BASIC SCOPES
        scope :nested_set,          order('lft ASC')
        scope :reversed_nested_set, order('lft DESC')
      end
    end
  end
end
