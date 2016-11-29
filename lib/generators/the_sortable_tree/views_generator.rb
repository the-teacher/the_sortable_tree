module TheSortableTree
  module Generators
    class ViewsGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../../../../app/views', __FILE__)

      def self.banner
<<-BANNER.chomp

bundle exec rails g the_sortable_tree:views tree
bundle exec rails g the_sortable_tree:views sortable
bundle exec rails g the_sortable_tree:views nested_options
bundle exec rails g the_sortable_tree:views indented_options

bundle exec rails g the_sortable_tree:views helper

bundle exec rails g the_sortable_tree:views assets

BANNER
      end

      def copy_sortable_tree_files
        copy_helper_files
      end

      private

      def param_name
        name.downcase
      end

      def copy_helper_files
        if param_name == 'tree'
          puts "Copy of tree render helper file"
          copy_file "../helpers/render_tree_helper.rb", "app/helpers/render_tree_helper.rb"
        elsif param_name == 'sortable'
          puts "Copy of sortable tree render helper file"
          copy_file "../helpers/render_sortable_tree_helper.rb", "app/helpers/render_sortable_tree_helper.rb"
        elsif param_name == 'nested_options'
          puts "Copy of nested options tree render helper file"
          copy_file "../helpers/render_nested_options_helper.rb", "app/helpers/render_nested_options_helper.rb"
        elsif param_name == 'indented_options'
          puts "Copy of indented options tree render helper file"
          copy_file "../helpers/render_indented_options_helper.rb", "app/helpers/render_indented_options_helper.rb"
        elsif param_name == 'helper'
          puts "Copy of base nested set render helper file"
          copy_file "../helpers/the_sortable_tree_helper.rb", "app/helpers/the_sortable_tree_helper.rb"
        elsif param_name == 'assets'
          directory "../assets/javascripts", "app/assets/javascripts"
        else
          puts "Wrong params - use only [assets | tree | sortable] values"
        end
      end

    end
  end
end
