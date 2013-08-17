# This migration comes from a2 (originally 20130815223918)
class CreateA2Feeds < ActiveRecord::Migration
  def change
    create_table :a2_feeds do |t|
      t.string :source
      t.string :type
      t.datetime :date
      t.string :item_id
      t.string :tags
      t.string :url
      t.text :json
      t.string :image_url

      t.timestamps
    end
  end
end
