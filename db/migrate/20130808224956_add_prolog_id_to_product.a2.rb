# This migration comes from a2 (originally 20130620144019)
class AddPrologIdToProduct < ActiveRecord::Migration
  def change
    add_column :a2_products, :prolog_code, :integer
  end
end
