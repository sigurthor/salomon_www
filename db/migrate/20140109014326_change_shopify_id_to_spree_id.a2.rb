# This migration comes from a2 (originally 20131121115434)
class ChangeShopifyIdToSpreeId < ActiveRecord::Migration
  def change
    rename_column :a2_products, :shopify_id, :spree_id
    rename_column :a2_product_variants, :shopify_id, :spree_id
  end
end
