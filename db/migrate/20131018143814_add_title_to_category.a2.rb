# This migration comes from a2 (originally 20131010162507)
class AddTitleToCategory < ActiveRecord::Migration
  def change
    add_column :a2_categories, :title, :string
  end
end
