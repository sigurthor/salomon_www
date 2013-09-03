# This migration comes from a2 (originally 20130903120140)
class AddImgToFeed < ActiveRecord::Migration
  def change
    add_column :a2_feeds, :img, :string
  end
end
