class AddPositionToModels < ActiveRecord::Migration
  def change
    %w(admin_pages article_categories inventory_categories pages).each do |table|
      add_column table, :position, :integer
    end
  end
end
