# This migration comes from a2 (originally 20140822143415)
class AddSeasonToProductColorVariant < ActiveRecord::Migration
  def up
    add_column :a2_product_color_variants, :season, :string

    A2::ProductColorVariant.all.each{ |cv| cv.update_attributes(:season => cv.product_variants.first.season)}

  end

  def down
    remove_column :a2_product_color_variants, :season
  end
end
