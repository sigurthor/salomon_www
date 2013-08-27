# This migration comes from a2 (originally 20130826213101)
class CreateA2Prices < ActiveRecord::Migration
  def change
    create_table :a2_prices do |t|
      t.decimal :price, :precision => 8, :scale => 2
      t.string :product_variant_id
      t.integer :country_id

      t.timestamps
    end

    add_index :a2_prices, [:product_variant_id, :country_id], :name => 'product_price',:unique => :true
  end
end
