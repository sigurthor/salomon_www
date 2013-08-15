# This migration comes from a2 (originally 20130815122347)
class CreateA2TeamMembers < ActiveRecord::Migration
  def change
    create_table :a2_team_members do |t|
      t.string :name
      t.string :slug
      t.string :fullname
      t.text :description
      t.string :country
      t.string :city
      t.string :vimeo
      t.integer :category_id
      t.string :tag_line
      t.string :video
      t.string :facebook
      t.string :twitter
      t.string :website
      t.string :instragram
      t.string :thumb_image
      t.string :main_image
      t.string :gender
      t.boolean :visible, :default => true

      t.timestamps
    end
  end
end
