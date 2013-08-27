# This migration comes from a2 (originally 20130826212544)
class CreateA2Regions < ActiveRecord::Migration
  def change
    create_table :a2_regions do |t|
      t.string :name

      t.timestamps
    end
  end
end
