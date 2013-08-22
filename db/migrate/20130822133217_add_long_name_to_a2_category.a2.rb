# This migration comes from a2 (originally 20130822132534)
class AddLongNameToA2Category < ActiveRecord::Migration
  def change
    add_column :a2_categories, :long_name, :string
  end
end
