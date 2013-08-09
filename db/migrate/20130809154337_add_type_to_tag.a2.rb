# This migration comes from a2 (originally 20130709094705)
class AddTypeToTag < ActiveRecord::Migration
  def change
    add_column :tags, :tag_type, :string
  end
end
