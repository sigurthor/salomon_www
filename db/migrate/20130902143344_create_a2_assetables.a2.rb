# This migration comes from a2 (originally 20130902143235)
class CreateA2Assetables < ActiveRecord::Migration
  def change
    create_table :a2_assetables do |t|
      t.integer :asset_id
      t.integer :assetable_id
      t.string :assetable_type

      t.timestamps
    end
  end
end
