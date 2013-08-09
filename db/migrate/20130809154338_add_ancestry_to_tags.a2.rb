# This migration comes from a2 (originally 20130709103136)
class AddAncestryToTags < ActiveRecord::Migration
  def change
    add_column :tags, :ancestry, :string
    add_column :tags, :position, :integer
    add_index :tags, :ancestry
  end
end
