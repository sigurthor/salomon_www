# This migration comes from a2 (originally 20130820110808)
class AddNameSingularToCategory < ActiveRecord::Migration
  def change
    add_column :a2_categories, :name_singular, :string
  end
end
