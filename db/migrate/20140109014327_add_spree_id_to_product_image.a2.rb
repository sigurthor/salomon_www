# This migration comes from a2 (originally 20131121122149)
class AddSpreeIdToProductImage < ActiveRecord::Migration
  def change
    add_column :a2_product_images, :spree_id, :integer
  end
end
