# This migration comes from a2 (originally 20140605145626)
class AddInstagramToTeamMember < ActiveRecord::Migration
  def change
    add_column :a2_team_members, :instagram, :string
  end
end
