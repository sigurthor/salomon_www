# This migration comes from a2 (originally 20130619191228)
class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :a2_product_types do |t|
      t.string :name
      t.integer :code

      t.timestamps
    end

    add_index :a2_product_types, :code, :unique => true
  end
end
