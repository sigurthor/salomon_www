# This migration comes from a2 (originally 20130710214720)
class AddBrandToProlougeTables < ActiveRecord::Migration
  def change
    [:a2_product_features,:a2_product_feature_types].each do |table|
      add_column table, :brand, :string
    end
  end
end
