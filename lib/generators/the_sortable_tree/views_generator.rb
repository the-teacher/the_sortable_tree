module TheSortableTree
  module Generators
    class ViewsGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../../../../app/views', __FILE__)

      def self.banner
        <<-BANNER.chomp
rails g the_sortable_tree:views MODEL [tree|sortable|comments]
  Copies files for rendering sortable nested set
        BANNER
      end

      def copy_sortable_tree_files
        # sortable
        # comments
        # tree
        if ARGV[1] == 'sortable'
          directory "../assets/javascripts/sortable", "app/assets/javascripts/sortable"
          directory "sortable/base", "app/views/#{folder}/sortable/base"
        elsif ARGV[1] == 'comments'
          directory "../assets/javascripts/comments", "app/assets/javascripts/comments"
          directory "comments/base", "app/views/#{folder}/comments/base"
        else
          directory "tree/base", "app/views/#{folder}/tree/base"
        end
      end

      private

      def folder
        name.pluralize.downcase
      end

    end
  end
end