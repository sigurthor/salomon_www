# This migration comes from a2 (originally 20131210182124)
class AddCostToProduct < ActiveRecord::Migration
  def change
    add_column :a2_products, :cost, :decimal,  precision: 8, scale: 2
  end
end
