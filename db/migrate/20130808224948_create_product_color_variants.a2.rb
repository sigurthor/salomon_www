# This migration comes from a2 (originally 20130619215513)
class CreateProductColorVariants < ActiveRecord::Migration
  def change
    create_table :a2_product_color_variants do |t|
      t.string :sap
      t.string :color_1_code
      t.string :color_1_name
      t.string :model
      t.boolean :has_photos

      t.timestamps
    end

    add_index :a2_product_color_variants, :sap, :unique => true

  end
end
