# This migration comes from a2 (originally 20130814143006)
class AddShowInCategoryOverviewToProductFeatureType < ActiveRecord::Migration
  def change
    add_column :a2_product_feature_types, :show_in_category_overview, :boolean
  end
end
