# This migration comes from a2 (originally 20130619150649)
class CreateProducts < ActiveRecord::Migration
  def change
    create_table :a2_products do |t|
      t.string :model
      t.string :brand
      t.string :name
      t.integer :master_article_code
      t.text :description
      t.integer :product_type_id

      t.timestamps
    end

    add_index :a2_products,:model, :unique => true

  end
end
