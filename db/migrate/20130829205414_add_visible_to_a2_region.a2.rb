# This migration comes from a2 (originally 20130829205310)
class AddVisibleToA2Region < ActiveRecord::Migration
  def change
    add_column :a2_regions, :visible, :boolean
  end
end
