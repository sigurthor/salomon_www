# This migration comes from a2 (originally 20130620152703)
class CreateProductFeatureTypes < ActiveRecord::Migration
  def change
    create_table :a2_product_feature_types do |t|
      t.integer :feature_type_code
      t.string :name

      t.timestamps
    end

    add_index :a2_product_feature_types, :feature_type_code, :unique => true
  end
end
