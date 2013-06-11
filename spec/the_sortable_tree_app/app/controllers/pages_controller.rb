class PagesController < ApplicationController
  # include TheSortableTreeController::ExpandNode

  include TheSortableTreeController::Rebuild

  def index
    @pages = Page.nested_set.select('id, title, content, parent_id').limit(5)
  end

  def manage
    @pages = Page.nested_set.select('id, title, content, parent_id')
  end

  # def expand
  #   @pages = Page.nested_set.roots.select('id, title, content, parent_id')
  # end  
end
