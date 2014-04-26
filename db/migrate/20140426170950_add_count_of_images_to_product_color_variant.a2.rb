# This migration comes from a2 (originally 20140304103114)
class AddCountOfImagesToProductColorVariant < ActiveRecord::Migration
  def up
    add_column :a2_product_color_variants, :product_images_count, :integer
    A2::ProductColorVariant.reset_column_information
    A2::ProductColorVariant.all.each do |cv|
      A2::ProductColorVariant.update_counters cv.id, :product_images_count => cv.product_images.length
    end
  end

  def down
    remove_column :a2_product_color_variants, :product_images_count
  end
end
