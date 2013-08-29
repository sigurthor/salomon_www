class TeamController < BaseController
  def index
    page 'team'
    if(params[:category])
      @team_categories = [A2::TeamCategory.includes(:team_members).find_by_slug(params[:category])]
    else
      @team_categories = A2::TeamCategory.includes(:team_members).find_by_slug('salomon').descendants
    end
    respond_to do |format|
      format.html
      format.json { render :json => @team_categories.to_json(:only => [:name,:slug],:include => {:team_members => {:only =>[:name, :slug,:country],:methods => 'thumb_image_identifier'}}) }
    end

  end

  def show
    page 'team-member'
    @team_categories = A2::TeamCategory.find_by_slug('salomon').descendants  unless params[:ajax]
    @team_member = A2::TeamMember.find_by_slug(params[:team_member])
    @profile_video = @team_member.video

    if params[:ajax]
      render :layout => false
    end

  end
end
