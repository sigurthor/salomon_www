# This migration comes from a2 (originally 20130620150918)
class CreateProductFeatureTable < ActiveRecord::Migration
  def change
    create_table :a2_product_features do |t|
      t.integer :feature_code
      t.integer :feature_type_code
      t.string :name
      t.text :description

      t.timestamps
    end

    add_index :a2_product_features, :feature_code, :unique => :true
  end
end
