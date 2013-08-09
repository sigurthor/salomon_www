# This migration comes from a2 (originally 20130710201121)
class AddBrandToManyTables < ActiveRecord::Migration
  def change

    [:a2_product_types,:a2_product_color_variants,:a2_product_families].each do |table|
      add_column table, :brand, :string
    end
  end
end
