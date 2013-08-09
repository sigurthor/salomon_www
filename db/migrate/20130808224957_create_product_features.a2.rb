# This migration comes from a2 (originally 20130620145557)
class CreateProductFeatures < ActiveRecord::Migration
  def change
    create_table :a2_product_product_features do |t|
      t.integer :prolog_code
      t.integer :feature_code

      t.timestamps
    end

    add_index :a2_product_product_features, [:prolog_code, :feature_code], :name => 'prolog_code_feature_code', :unique => :true
  end


end
