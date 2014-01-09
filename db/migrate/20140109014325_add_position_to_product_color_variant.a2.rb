# This migration comes from a2 (originally 20131103213509)
class AddPositionToProductColorVariant < ActiveRecord::Migration
  def change
    add_column :a2_product_color_variants, :position, :integer
  end
end
