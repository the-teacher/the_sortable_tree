class AddAncestryToModels < ActiveRecord::Migration
  def change
    %w(admin_pages article_categories inventory_categories pages).each do |table|
      add_column table, :ancestry, :string
      add_index table, :ancestry
    end
  end
end
