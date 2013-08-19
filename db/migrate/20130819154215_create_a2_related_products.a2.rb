# This migration comes from a2 (originally 20130819142427)
class CreateA2RelatedProducts < ActiveRecord::Migration
  def change
    create_table :a2_related_products  do |t|
      t.integer :product_id
      t.integer :related_product_id

      t.timestamps
    end

    add_index :a2_related_products, [:product_id,:related_product_id], :name => 'product_related', :unique => true
  end
end
