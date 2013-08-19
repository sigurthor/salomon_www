# This migration comes from a2 (originally 20130819132718)
class CreateA2TeamMemberProducts < ActiveRecord::Migration
  def change
    create_table :a2_team_member_products do |t|
      t.integer :team_member_id
      t.integer :product_id
      t.integer :position

      t.timestamps
    end

    add_index :a2_team_member_products, [:team_member_id, :product_id], :name => 'team_member_product', :unique => true

  end
end
