# This migration comes from a2 (originally 20130709205247)
class AddTypeToCategory < ActiveRecord::Migration
  def change
    add_column :a2_categories, :type, :string
  end
end
