class TeamController < BaseController
  def index
    @team_categories = A2::TeamCategory.find_by_slug('salomon').descendants
  end

  def show
    @team_member = A2::TeamMember.find_by_slug(params[:team_member])
  end
end
