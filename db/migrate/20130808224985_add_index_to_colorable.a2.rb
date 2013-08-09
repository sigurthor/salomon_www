# This migration comes from a2 (originally 20130717112749)
class AddIndexToColorable < ActiveRecord::Migration
  def change
    add_index :a2_colorables, [:color_code,:colorable_id,:colorable_type], :name => 'code_id_type', :unique => true
  end
end
