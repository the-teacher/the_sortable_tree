class PagesController < ApplicationController
  include TheSortableTreeController::Rebuild
  include TheSortableTreeController::ExpandNode

  def index
    @pages = Page.nested_set.select('id, title, content, parent_id, ancestry').limit(15)
  end

  def nested_options
    @pages = Page.nested_set.select('id, title, content, parent_id, ancestry').limit(15)
  end

  def manage
    @pages = Page.nested_set.select('id, title, content, parent_id, ancestry').all
  end

  def node_manage
    @root  = Page.roots.first
    if @root.respond_to? :self_and_descendants
      # awesome_nested_set
      @pages = @root.self_and_descendants.nested_set.select('id, title, content, parent_id, ancestry').limit(15)
    else
      # ancestry
      @pages = @root.subtree.nested_set.select('id, title, content, parent_id, ancestry').limit(15)
    end
    render template: 'pages/manage'
  end

  def expand
    @pages = Page.nested_set.roots.select('id, title, content, parent_id, ancestry')
  end
end
