# This migration comes from a2 (originally 20130619184918)
class AddProductLineToProduct < ActiveRecord::Migration
  def change
    add_column :a2_products, :product_line, :string
  end
end
