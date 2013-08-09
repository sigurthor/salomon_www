# This migration comes from a2 (originally 20130619205554)
class AddBrandToProductVariant < ActiveRecord::Migration
  def change
    add_column :a2_product_variants, :brand, :string
  end
end
