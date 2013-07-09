class PagesController < ApplicationController
  include TheSortableTreeController::Rebuild
  include TheSortableTreeController::ExpandNode

  def index
    @pages = Page.nested_set.select('id, title, content, parent_id').limit(15)
  end

  def nested_options
    @pages = Page.nested_set.select('id, title, content, parent_id').limit(15)
  end

  def manage
    @pages = Page.nested_set.select('id, title, content, parent_id')
  end

  def node_manage
    @root  = Page.root
    @pages = @root.self_and_descendants.nested_set.select('id, title, content, parent_id').limit(15)
    render template: 'pages/manage'
  end

  def expand
    @pages = Page.nested_set.roots.select('id, title, content, parent_id')
  end
end
