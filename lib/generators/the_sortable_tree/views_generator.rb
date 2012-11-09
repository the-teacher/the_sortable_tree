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

        # expandable [todo]
        # select [todo]
        if ARGV[1] == 'sortable'
          copy_file "../assets/stylesheets/sortable.css.scss", "app/assets/stylesheets/sortable.css.scss"
          directory "../assets/javascripts/sortable", "app/assets/javascripts/sortable"
          directory "sortable/client", "app/views/#{folder}/sortable/client"
        elsif ARGV[1] == 'comments'
          copy_file "../assets/stylesheets/comments_tree.css.scss", "app/assets/stylesheets/comments_tree.css.scss"
          directory "../assets/javascripts/comments", "app/assets/javascripts/comments"
          directory "comments/client", "app/views/#{folder}/comments/client"
        else
          copy_file "../assets/stylesheets/tree.css.scss", "app/assets/stylesheets/tree.css.scss"
          directory "../assets/javascripts/tree", "app/assets/javascripts/tree"
          directory "tree/client", "app/views/#{folder}/tree/client"
        end
      end

      private

      def folder
        name.pluralize.downcase
      end

    end
  end
end