# This migration comes from a2 (originally 20130815135319)
class ChangeColumnTeamMemberCategoryId < ActiveRecord::Migration
  def change
    rename_column :a2_team_members, :category_id, :team_category_id
  end
end
