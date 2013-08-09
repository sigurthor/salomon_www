# This migration comes from a2 (originally 20130620150520)
class RenameProductFeatureToProductProductFeature < ActiveRecord::Migration
  def up
  #  rename_table :product_features, :product_product_features
  end

  def down
   # rename_table :product_product_features, :product_features
  end
end
