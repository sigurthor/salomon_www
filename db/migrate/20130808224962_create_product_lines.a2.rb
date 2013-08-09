# This migration comes from a2 (originally 20130621174813)
class CreateProductLines < ActiveRecord::Migration
  def change
    create_table :a2_product_lines do |t|
      t.string :product_line_code
      t.string :product_line_name

      t.timestamps
    end
  end
end
