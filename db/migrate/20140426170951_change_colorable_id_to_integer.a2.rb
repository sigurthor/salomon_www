# This migration comes from a2 (originally 20140304114718)
class ChangeColorableIdToInteger < ActiveRecord::Migration
  def up
    change_column :a2_colorables, :colorable_id, 'integer USING CAST(colorable_id AS integer)'
  end

  def down
    change_column :a2_colorables, :colorable_id, :string
  end
end