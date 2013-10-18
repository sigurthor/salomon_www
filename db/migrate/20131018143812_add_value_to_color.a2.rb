# This migration comes from a2 (originally 20131008115221)
class AddValueToColor < ActiveRecord::Migration
  def change
    add_column :a2_colors, :value, :string , :default => 'ffffff'
  end
end
