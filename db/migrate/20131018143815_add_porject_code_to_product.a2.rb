# This migration comes from a2 (originally 20131011003543)
class AddPorjectCodeToProduct < ActiveRecord::Migration
  def change
    add_column :a2_products, :project_code, :string
  end
end
