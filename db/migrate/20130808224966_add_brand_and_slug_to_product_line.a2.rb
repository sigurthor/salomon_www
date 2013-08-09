# This migration comes from a2 (originally 20130621202455)
class AddBrandAndSlugToProductLine < ActiveRecord::Migration
  def change
    add_column :a2_product_lines, :brand, :string
    add_column :a2_product_lines, :slug, :string
  end
end
