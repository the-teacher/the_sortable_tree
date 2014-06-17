class Admin::PagesController < ApplicationController
  include TheSortableTreeController::Rebuild

  def index
    @pages = Admin::Page.nested_set.select('id, title, content, parent_id, ancestry').limit(15)
  end

  def manage
    @pages = Admin::Page.nested_set.select('id, title, content, parent_id, lft').limit(15)
  end

  def nested_options
    @pages = Admin::Page.nested_set.select('id, title, content, parent_id, ancestry').limit(15)
  end

  def node_manage
    @root  = Admin::Page.roots.first

    @pages = if Page.sortable_tree_type?(:nested_set)
      @root.self_and_descendants.nested_set.select('id, title, content, parent_id, ancestry').limit(15)
    else
      @root.subtree.nested_set.select('id, title, content, parent_id, ancestry').limit(15)
    end

    render template: 'admin/pages/manage'
  end

  def sortable_model
    Admin::Page
  end

  def sortable_collection
    'admin_pages'
  end
end
