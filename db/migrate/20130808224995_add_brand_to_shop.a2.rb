# This migration comes from a2 (originally 20130727171836)
class AddBrandToShop < ActiveRecord::Migration
  def change
    add_column :a2_shops, :brand, :string
  end
end
