# This migration comes from a2 (originally 20130709195937)
class CreateCategories < ActiveRecord::Migration
  def change
    create_table :a2_categories do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.string :img
      t.integer :position
      t.boolean :visible
      t.string :ancestry

      t.timestamps
    end

    add_index :a2_categories, :slug
    add_index :a2_categories, :ancestry
  end
end
