# This migration comes from a2 (originally 20130125233937)
class CreateTechFeatures < ActiveRecord::Migration
  def up
    create_table :a2_tech_features do |t|
      t.string :name
      t.string :logo

      t.timestamps
    end

    A2::TechFeature.create_translation_table! :description => :string, :image => :string

  end

  def down
    A2::TechFeature.drop_translation_table
  end
end
