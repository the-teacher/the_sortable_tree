class Admin::PagesController < ApplicationController
  include TheSortableTreeController::Rebuild

  def index
    @pages = Page.nested_set.select('id, title, content, parent_id').limit(1000)
  end

  def manage
    @pages = Page.nested_set.select('id, title, content, parent_id').limit(1000)
  end

  def first_root_manage
    @root  = Page.root
    @pages = @root.descendants.nested_set.select('id, title, content, parent_id').limit(1000)
  end

  def namespaced_pages
    @pages = Admin::Page.nested_set.select('id, title, content, parent_id').limit(1000)
  end

  protected 

  def sortable_model
    Admin::Page
  end

  def sortable_collection
    "admin_pages"
  end
end
