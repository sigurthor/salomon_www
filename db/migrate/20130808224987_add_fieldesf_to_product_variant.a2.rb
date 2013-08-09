# This migration comes from a2 (originally 20130717124754)
class AddFieldesfToProductVariant < ActiveRecord::Migration
  def change
    add_column :a2_product_variants, :technical_size, :integer
    add_column :a2_product_variants, :description, :string
    add_column :a2_product_variants, :short_description, :string
    add_column :a2_product_variants, :price_eu, :integer
    add_column :a2_product_variants, :price_us, :integer
    add_column :a2_product_variants, :sourcing_country, :string
    add_column :a2_product_variants, :weight, :integer
    add_column :a2_product_variants, :dimensions, :string
  end
end
