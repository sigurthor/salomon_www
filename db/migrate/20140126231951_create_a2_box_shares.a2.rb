# This migration comes from a2 (originally 20140126225533)
class CreateA2BoxShares < ActiveRecord::Migration
  def change
    create_table :a2_box_shares do |t|
      t.string :title
      t.string :slug
      t.datetime :expire

      t.timestamps
    end
  end
end
