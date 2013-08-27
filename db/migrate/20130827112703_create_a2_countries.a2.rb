# This migration comes from a2 (originally 20130826212458)
class CreateA2Countries < ActiveRecord::Migration
  def change
    create_table :a2_countries do |t|
      t.string :name
      t.string :iso_code
      t.string :currency
      t.string :store_url
      t.string :locale
      t.integer :region_id

      t.timestamps
    end
  end
end
