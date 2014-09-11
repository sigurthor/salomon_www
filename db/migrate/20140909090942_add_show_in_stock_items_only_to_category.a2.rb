# This migration comes from a2 (originally 20140625152318)
class AddShowInStockItemsOnlyToCategory < ActiveRecord::Migration
  def change
    add_column :a2_categories, :show_in_stock_only, :boolean
  end
end
