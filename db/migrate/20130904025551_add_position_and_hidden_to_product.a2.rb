# This migration comes from a2 (originally 20130904024120)
class AddPositionAndHiddenToProduct < ActiveRecord::Migration
  def change
    add_column :a2_products, :hidden, :boolean
    add_column :a2_products, :position, :integer
  end
end
