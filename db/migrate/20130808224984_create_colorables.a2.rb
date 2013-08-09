# This migration comes from a2 (originally 20130716172111)
class CreateColorables < ActiveRecord::Migration
  def change
    create_table :a2_colorables do |t|
      t.integer :color_code
      t.string :colorable_type
      t.string :colorable_id
      t.integer :position

      t.timestamps
    end
  end
end
