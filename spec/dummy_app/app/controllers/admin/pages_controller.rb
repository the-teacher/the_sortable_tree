class Admin::PagesController < ApplicationController
  include TheSortableTreeController::Rebuild

  def index
    @pages = Admin::Page.nested_set.select('id, title, content, parent_id').limit(15)
  end

  def manage
    @pages = Admin::Page.nested_set.select('id, title, content, parent_id').limit(15)
  end

  def nested_options
    @pages = Admin::Page.nested_set.select('id, title, content, parent_id').limit(15)
  end

  def node_manage
    @root  = Admin::Page.root
    @pages = @root.self_and_descendants.nested_set.select('id, title, content, parent_id').limit(15)
    render template: 'admin/pages/manage'
  end

  protected 

  def sortable_model
    Admin::Page
  end

  def sortable_collection
    'admin_pages'
  end
end
