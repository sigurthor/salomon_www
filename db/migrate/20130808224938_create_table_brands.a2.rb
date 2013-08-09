# This migration comes from a2 (originally 20130313210148)
class CreateTableBrands < ActiveRecord::Migration
  def change
    create_table :a2_brands, :id => false do |t|
      t.string :id
      t.string :name
      t.string :domains
      t.text :description

      t.timestamps
    end
  end
end
