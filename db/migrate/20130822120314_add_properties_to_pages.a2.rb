# This migration comes from a2 (originally 20130822120040)
class AddPropertiesToPages < ActiveRecord::Migration
  def change
    add_column :a2_pages, :title, :string
    add_column :a2_pages, :title_browser, :string
    add_column :a2_pages, :slug, :string
    add_column :a2_pages, :description, :text
  end
end
