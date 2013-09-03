# This migration comes from a2 (originally 20130902114656)
class CreateA2Assets < ActiveRecord::Migration
  def change
    create_table :a2_assets do |t|
      t.string :title
      t.string :description
      t.string :img
      t.string :video_id
      t.string :video_url
      t.string :video_image_url
      t.string :type

      t.timestamps
    end
  end
end
