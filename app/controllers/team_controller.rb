class TeamController < BaseController
  def index
    @team_categories = A2::TeamCategory.find_by_slug('salomon').descendants
  end

  def show
    @team_categories = A2::TeamCategory.find_by_slug('salomon').descendants
    @team_member = A2::TeamMember.find_by_slug(params[:team_member])
    @total_riders = @team_member.category.team_members.count
  end
end
