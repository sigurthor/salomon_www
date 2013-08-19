# This migration comes from a2 (originally 20130819153500)
class AddQouterNameAndQouterTitleToTeamMember < ActiveRecord::Migration
  def change
    add_column :a2_team_members, :quoter_name, :string
    add_column :a2_team_members, :quoter_title, :string
  end
end
