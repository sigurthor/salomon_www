# This migration comes from a2 (originally 20130820135048)
class CreateA2Pages < ActiveRecord::Migration
  def up
    create_table :a2_pages do |t|
      t.string :img
      t.string :pid
      t.integer :category_id
      t.string :layout

      t.timestamps
    end

    add_index :a2_pages, :pid, :unique => true
    A2::Page.create_translation_table! :title => :string, :title_browser => :string , :slug => :string , :description => :text

  end

  def down
    drop_table :a2_pages
    A2::Page.drop_translation_table!
  end


end
