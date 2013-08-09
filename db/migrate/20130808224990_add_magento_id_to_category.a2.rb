# This migration comes from a2 (originally 20130717212730)
class AddMagentoIdToCategory < ActiveRecord::Migration
  def change
    add_column :a2_categories, :magento_id, :integer
  end
end
