class HomeController < ApplicationController
  def index
    @vimeo = A2::VimeoFeed.first

    team_categories = A2::TeamCategory.find_by_slug('salomon').descendants
    @team_categories_info =  team_categories.map {|c| {name: c.name,count: c.team_members.count}}
    @pro_team_members = team_categories.map {|c| c.team_members if c.slug == 'pros'}.first  #todo hafa ekki slug í kóða

  end

  def contact

  end

  def terms

  end

  def privacy_policy

  end

  def warranty

  end
end
