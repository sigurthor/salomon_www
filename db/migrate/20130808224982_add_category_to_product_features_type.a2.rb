# This migration comes from a2 (originally 20130711181209)
class AddCategoryToProductFeaturesType < ActiveRecord::Migration
  def change
    add_column :a2_product_feature_types, :category, :string
  end
end
