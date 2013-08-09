# This migration comes from a2 (originally 20130711090431)
class AddBrandToProductImage < ActiveRecord::Migration
  def up
    add_column :a2_product_images, :brand, :string

    A2::ProductImage.all.each do |image|
      puts image.s3_key
      image.brand = image.product_color_variant.brand if image.product_color_variant
      image.save
    end
  end

  def down
    remove_column :a2_product_images, :brand
  end

end
