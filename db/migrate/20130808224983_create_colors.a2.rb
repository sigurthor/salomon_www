# This migration comes from a2 (originally 20130716170125)
class CreateColors < ActiveRecord::Migration
  def change
    create_table :a2_colors do |t|
      t.string :name
      t.string :code
      t.string :brand

      t.timestamps
    end

    add_index :a2_colors, [:code,:brand], :name => 'brand_colors', :unique => true
  end
end
