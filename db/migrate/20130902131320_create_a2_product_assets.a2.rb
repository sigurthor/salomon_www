# This migration comes from a2 (originally 20130902115041)
class CreateA2ProductAssets < ActiveRecord::Migration
  def change
    create_table :a2_product_assets do |t|
      t.integer :asset_id
      t.integer :product_id
      t.string :type

      t.timestamps
    end
  end
end
