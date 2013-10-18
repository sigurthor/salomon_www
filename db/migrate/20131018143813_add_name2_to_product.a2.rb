# This migration comes from a2 (originally 20131008161854)
class AddName2ToProduct < ActiveRecord::Migration
  def up
    add_column :a2_products, :name2, :string


  end

  def down
    remove_column :a2_products, :name2
  end
end
