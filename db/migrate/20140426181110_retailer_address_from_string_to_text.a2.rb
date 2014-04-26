# This migration comes from a2 (originally 20140426181014)
class RetailerAddressFromStringToText < ActiveRecord::Migration
  def up
    change_column :a2_retailers, :address, :text
  end

  def down
    change_column :a2_retailers, :address, :string
  end
end
