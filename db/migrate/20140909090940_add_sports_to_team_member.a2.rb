# This migration comes from a2 (originally 20140605150401)
class AddSportsToTeamMember < ActiveRecord::Migration
  def change
    add_column :a2_team_members, :sports, :string
  end
end
