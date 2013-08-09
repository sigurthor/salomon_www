# This migration comes from a2 (originally 20130718221920)
class AddTranslationToProduct < ActiveRecord::Migration
  def up
    A2::Product.create_translation_table!({:description => :text, :tag_line => :string},{:migrate_data => true})
  end

  def down
    A2::Product.drop_translation_table!
  end
end
