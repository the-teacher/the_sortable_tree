class ArticleCategoriesController < ApplicationController
  include TheSortableTreeController::Rebuild

  def index
    @article_categories = ArticleCategory.nested_set.all
  end

  def manage
    @article_categories = ArticleCategory.nested_set.all
  end
end
