# This migration comes from a2 (originally 20130620083245)
class AddGenderToProductAndVariant < ActiveRecord::Migration
  def change
    add_column :a2_products, :gender, :string
    add_column :a2_product_variants, :gender, :string
  end
end
