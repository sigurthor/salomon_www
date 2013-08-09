# This migration comes from a2 (originally 20130125203352)
class CreateBrands < ActiveRecord::Migration
  def change
    create_table :a2_brands do |t|
      t.string :name
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end