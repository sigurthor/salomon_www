# This migration comes from a2 (originally 20130903121832)
class ChangeColoumnFeedTitleToText < ActiveRecord::Migration
  def up
    change_column :a2_feeds, :title, :text
  end

  def down
    change_column :a2_feeds, :title, :string
  end
end
