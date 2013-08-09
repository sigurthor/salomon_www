# This migration comes from a2 (originally 20130717113713)
class ChangeColorableColumnColorCode < ActiveRecord::Migration
  def up
    change_column :a2_colorables, :color_code, :string
  end

  def down
    change_column :a2_colorables, :color_code, :integer
  end
end
