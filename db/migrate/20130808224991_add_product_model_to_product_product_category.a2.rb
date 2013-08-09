# This migration comes from a2 (originally 20130717220305)
class AddProductModelToProductProductCategory < ActiveRecord::Migration
  def change
    add_column :a2_product_product_categories, :product_model, :string
  end
end
