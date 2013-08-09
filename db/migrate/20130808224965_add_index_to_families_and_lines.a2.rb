# This migration comes from a2 (originally 20130621181047)
class AddIndexToFamiliesAndLines < ActiveRecord::Migration
  def change
    add_index :a2_product_lines,:product_line_code, :unique => true
    add_index :a2_product_families, :product_family_code, :unique => true
  end
end
