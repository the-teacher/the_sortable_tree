module TheSortableTree
  module Generators
    class ViewsGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../../../../app/views', __FILE__)

      def self.banner
        <<-BANNER.chomp
rails g the_sortable_tree:views MODEL [min]
  Copies files for rendering sortable nested set
        BANNER
      end

      def copy_sortable_tree_files
        if ARGV[1] == 'min'
          directory "the_sortable_tree_min", "app/views/#{folder}/the_sortable_tree_min"
        else
          directory "the_sortable_tree", "app/views/#{folder}/the_sortable_tree"
        end
      end

      private

      def folder
        name.pluralize.downcase
      end

    end#ViewsGenerator
  end
end