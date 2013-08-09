# This migration comes from a2 (originally 20130711122147)
class AddProductFeatureTypeIdToProductFeature < ActiveRecord::Migration
  def change
    add_column :a2_product_features, :product_feature_type_id, :integer
  end
end
