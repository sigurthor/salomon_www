# This migration comes from a2 (originally 20130820191923)
class AddProductImageToProductVariant < ActiveRecord::Migration
  def change
    add_column :a2_product_variants, :product_image_id, :integer
  end
end
