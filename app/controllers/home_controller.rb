class HomeController < ApplicationController
  def index
    @vimeo = A2::VimeoFeed.first

    team_categorys = A2::TeamCategory.find_by_slug('salomon').descendants
    @team_categories_info =  team_categorys.map {|c| {name: c.name,count: c.team_members.count}}
    @pro_team_members = team_categorys.map {|c| c.team_members.limit(7) if c.slug == 'pro'}.first

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
