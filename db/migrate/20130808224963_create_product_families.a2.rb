# This migration comes from a2 (originally 20130621174848)
class CreateProductFamilies < ActiveRecord::Migration
  def change
    create_table :a2_product_families do |t|
      t.string :product_family_code
      t.string :product_family_name

      t.timestamps
    end
  end
end
