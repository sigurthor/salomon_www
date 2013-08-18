# This migration comes from a2 (originally 20130817204429)
class AddTileToFeed < ActiveRecord::Migration
  def change
    add_column :a2_feeds, :title, :string
  end
end
