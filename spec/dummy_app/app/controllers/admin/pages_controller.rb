class Admin::PagesController < ApplicationController
  include TheSortableTreeController::Rebuild

  def index
    @pages = Admin::Page.nested_set.select('id, title, content, parent_id, ancestry').limit(15)
  end

  def manage
    @pages = Admin::Page.nested_set.select('id, title, content, parent_id, ancestry').limit(15)
  end

  def nested_options
    @pages = Admin::Page.nested_set.select('id, title, content, parent_id, ancestry').limit(15)
  end

  def node_manage
    @root  = Admin::Page.roots.first
    if @root.respond_to? :self_and_descendants
      # awesome_nested_set
      @pages = @root.self_and_descendants.nested_set.select('id, title, content, parent_id, ancestry').limit(15)
    else
      # ancestry
      @pages = @root.subtree.nested_set.select('id, title, content, parent_id, ancestry').limit(15)
    end
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
