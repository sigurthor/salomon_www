# This migration comes from a2 (originally 20130822113223)
class AddHtmlToPage < ActiveRecord::Migration
  def change
    add_column :a2_pages, :html, :text
    add_column :a2_page_translations, :html, :text
  end
end
