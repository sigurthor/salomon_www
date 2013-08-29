# This migration comes from a2 (originally 20130829064957)
class AddSalomonUrlToPage < ActiveRecord::Migration
  def change
    add_column :a2_pages, :salomon_url, :string
  end
end
