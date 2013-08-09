# This migration comes from a2 (originally 20130623180656)
class AddNameToProductLine < ActiveRecord::Migration
  def change
    add_column :a2_product_lines, :name, :string
  end
end
