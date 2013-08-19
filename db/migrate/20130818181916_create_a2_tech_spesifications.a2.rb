# This migration comes from a2 (originally 20130818135635)
class CreateA2TechSpesifications < ActiveRecord::Migration
  def change
    create_table :a2_tech_specifications do |t|
      t.integer :prolouge_tech_definitaion_id
      t.integer :product_variant_id
      t.integer :tech_definition_id
      t.string :value
      t.string :unit

      t.timestamps
    end

    add_index :a2_tech_specifications,[:product_variant_id, :tech_definition_id],:name => 'product_tech_def', :unique => true
  end

end
