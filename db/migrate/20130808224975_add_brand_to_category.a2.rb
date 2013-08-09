# This migration comes from a2 (originally 20130710003745)
class AddBrandToCategory < ActiveRecord::Migration
  def change
    add_column :a2_categories, :brand, :string
  end
end
