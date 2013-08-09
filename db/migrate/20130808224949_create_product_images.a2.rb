# This migration comes from a2 (originally 20130619234104)
class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :a2_product_images do |t|
      t.string :sap
      t.string :size_code
      t.string :s3_key
      t.string :img
      t.integer :position

      t.timestamps
    end
  end
end
