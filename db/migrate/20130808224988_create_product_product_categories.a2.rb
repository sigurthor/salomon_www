# This migration comes from a2 (originally 20130717200646)
class CreateProductProductCategories < ActiveRecord::Migration
  def change
    create_table :a2_product_product_categories do |t|
      t.integer :product_id
      t.integer :category_id
      t.integer :product_category_id
      t.integer :position
      t.timestamps
    end
  end
end
