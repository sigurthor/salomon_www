# This migration comes from a2 (originally 20130619203451)
class RenameProductTypeColumns < ActiveRecord::Migration
  def up
    rename_column :a2_product_types, :name, :product_type_name
    rename_column :a2_product_types, :code, :product_type_code
  end

  def down
    rename_column :a2_product_types, :product_type_name, :name
    rename_column :a2_product_types, :product_type_code, :code
  end
end
