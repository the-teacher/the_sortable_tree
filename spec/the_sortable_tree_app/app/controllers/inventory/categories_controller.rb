class Inventory::CategoriesController < ApplicationController
  include TheSortableTreeController::Rebuild

  def sortable_model
    Inventory::Category
  end

  def index
    @inventory_categories = Inventory::Category.nested_set.all
  end

  def manage
    @inventory_categories = Inventory::Category.nested_set.all
  end
end
