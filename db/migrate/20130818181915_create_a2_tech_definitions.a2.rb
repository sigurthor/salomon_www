# This migration comes from a2 (originally 20130818130854)
class CreateA2TechDefinitions < ActiveRecord::Migration
  def change
    create_table :a2_tech_definitions do |t|
      t.string :name
      t.integer :position
      t.integer :prolouge_techdefnu
      t.boolean :show_in_porduct_detail

      t.timestamps
    end

    add_index :a2_tech_definitions, :prolouge_techdefnu, :unique => true
  end
end
