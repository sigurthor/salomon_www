# This migration comes from a2 (originally 20130727164924)
class CreateShops < ActiveRecord::Migration
  def change
    create_table :a2_shops do |t|
      t.string :name
      t.string :domain
      t.string :credentials

      t.timestamps
    end
  end
end
