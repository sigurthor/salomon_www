# This migration comes from a2 (originally 20130823100929)
class AddAccountToFeed < ActiveRecord::Migration
  def change
    add_column :a2_feeds, :account_username, :string
    add_column :a2_feeds, :account_id, :string
  end
end
