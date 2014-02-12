# This migration comes from a2 (originally 20140206164841)
class AddGoogleUrlToProductAndCategory < ActiveRecord::Migration
  def change
    add_column :a2_categories, :google_url, :string
    add_column :a2_products, :google_url, :string
  end
end
