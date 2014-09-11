# This migration comes from a2 (originally 20140602172618)
class CreateLookbook < ActiveRecord::Migration
  def change
    create_table :a2_lookbooks do |t|
      t.string :name
      t.string :description
      t.string :img
      t.string :slug
      t.string :position

      t.timestamps
    end
  end
end
