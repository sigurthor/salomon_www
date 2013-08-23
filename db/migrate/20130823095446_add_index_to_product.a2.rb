# This migration comes from a2 (originally 20130823085827)
class AddIndexToProduct < ActiveRecord::Migration
  def change
    add_index :a2_product_color_variants, :model
    add_index :a2_product_images, :sap
    add_index :a2_product_variants, :article_code
    add_index :a2_product_product_categories,[:product_category_id,:product_id],:name => 'product_category', :unique => true
  end
end
