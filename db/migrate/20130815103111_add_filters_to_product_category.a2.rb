# This migration comes from a2 (originally 20130815102930)
class AddFiltersToProductCategory < ActiveRecord::Migration
  def change
    add_column :a2_categories, :filters, :string
  end
end
