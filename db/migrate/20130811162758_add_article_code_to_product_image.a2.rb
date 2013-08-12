# This migration comes from a2 (originally 20130811160525)
class AddArticleCodeToProductImage < ActiveRecord::Migration
  def change
    add_column :a2_product_images, :variant_code, :integer
  end
end
