# This migration comes from a2 (originally 20131002220842)
class AddAncestryDepthToCategory < ActiveRecord::Migration
  def up
    add_column :a2_categories, :ancestry_depth, :integer , :default => 0
  end

  def down
    remove_column :a2_categories, :ancestry_depth
  end


end
