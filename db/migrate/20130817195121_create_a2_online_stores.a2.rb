# This migration comes from a2 (originally 20130817193850)
class CreateA2OnlineStores < ActiveRecord::Migration
  def change
    create_table :a2_online_stores do |t|
      t.string :name
      t.string :img
      t.string :url
      t.integer :category_id
      t.boolean :visible
      t.integer :position

      t.timestamps
    end
  end
end
