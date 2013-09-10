# This migration comes from a2 (originally 20130907155530)
class CreateA2Retailers < ActiveRecord::Migration
  def change
    create_table :a2_retailers do |t|
      t.string :name
      t.string :url
      t.string :address
      t.string :city
      t.string :state_province
      t.string :country
      t.string :phone
      t.string :postal_code
      t.boolean :hidden
      t.float :latitude
      t.float :longitude
      t.string :geo_address

      t.timestamps
    end
  end
end
