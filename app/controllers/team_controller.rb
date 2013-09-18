class TeamController < BaseController
  def index
    page 'team'
    if(params[:category])
      @team_categories = [A2::TeamCategory.includes(:team_members).find_by(:slug => params[:category])]
    else
      @team_categories = A2::TeamCategory.cached_deceandans_of('salomon')
    end
    respond_to do |format|
      format.html
      format.json { render :json => @team_categories.to_json(:only => [:name,:slug],:include => {:team_members => {:only =>[:name, :slug,:country],:methods => 'thumb_image_identifier'}}) }
    end

  end

  def show
    page 'team-member'
    @team_categories = A2::TeamCategory.cached_deceandans_of('salomon') unless params[:ajax]
    @team_member = A2::TeamMember.find_by(:slug => params[:team_member])
    @profile_video = @team_member.video

    if params[:ajax]
      render :layout => false
    end

  end
end
