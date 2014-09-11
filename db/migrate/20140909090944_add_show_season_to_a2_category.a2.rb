# This migration comes from a2 (originally 20140822150813)
class AddShowSeasonToA2Category < ActiveRecord::Migration
  def change
    add_column :a2_categories, :show_season, :string
  end
end
