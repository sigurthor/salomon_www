# This migration comes from a2 (originally 20130619195938)
class RenameColumnProductTypeId < ActiveRecord::Migration
  def up
    rename_column :a2_products, :product_type_id, :product_type_code
  end


  def down
    rename_column :a2_products, :product_type_code, :product_type_id
  end
end
