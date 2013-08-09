# This migration comes from a2 (originally 20130621175141)
class AddProductFamilyAndLineToProduct < ActiveRecord::Migration
  def change
    add_column :a2_products, :product_family_code, :string
    rename_column :a2_products, :product_line, :product_line_code
    add_column :a2_product_variants, :product_family_code, :string
    add_column :a2_product_variants, :product_line_code, :string
    add_column :a2_products, :season, :string
    add_column :a2_product_variants, :season, :string

  end
end
