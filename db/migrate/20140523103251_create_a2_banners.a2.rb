# This migration comes from a2 (originally 20140518140325)
class CreateA2Banners < ActiveRecord::Migration
  def change
    create_table :a2_banners do |t|
      t.string :pid
      t.string :title
      t.string :subtitle
      t.string :image
      t.string :video
      t.string :link_url
      t.string :link_text
      t.text :content
      t.integer :page_id

      t.timestamps
    end
  end
end
