# This migration comes from a2 (originally 20130711173824)
class AddPositionToProductFeature < ActiveRecord::Migration
  def change
    [:a2_product_features,:a2_product_feature_types].each do |table|
      add_column table, :position, :integer
    end
  end
end
