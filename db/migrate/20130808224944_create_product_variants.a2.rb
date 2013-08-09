# This migration comes from a2 (originally 20130619195300)
class CreateProductVariants < ActiveRecord::Migration
  def change
    create_table :a2_product_variants do |t|
      t.string :name
      t.string :model
      t.integer :article_code
      t.string :sap
      t.string :size_code
      t.string :color_1_code
      t.string :color_1_name
      t.string :size
      t.integer :ean

      t.timestamps
    end

    add_index :a2_product_variants, :size_code, :unique => true
  end
end
