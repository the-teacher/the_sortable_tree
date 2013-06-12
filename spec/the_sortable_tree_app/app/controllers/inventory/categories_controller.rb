class Inventory::CategoriesController < ApplicationController
  include TheSortableTreeController::Rebuild

  def index
    @inventory_categories = Inventory::Category.nested_set.all
  end

  def manage
    @inventory_categories = Inventory::Category.nested_set.all
  end

  def sortable_model
    Inventory::Category
  end
end
