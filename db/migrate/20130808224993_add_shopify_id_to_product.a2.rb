# This migration comes from a2 (originally 20130727143140)
class AddShopifyIdToProduct < ActiveRecord::Migration
  def change
    add_column :a2_products, :shopify_id, :integer
    add_column :a2_product_variants, :shopify_id, :integer
  end
end
