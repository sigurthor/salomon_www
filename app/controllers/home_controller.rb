class HomeController < ApplicationController
  def index
    page 'home'

    @vimeo = A2::VimeoFeed.first
    team_categories = A2::TeamCategory.find_by_slug('salomon').descendants
    @team_categories_info =  team_categories.map {|c| {name: c.name,count: c.team_members.count}}
    @pro_team_members = team_categories.map {|c| c.team_members if c.slug == 'pros'}.first  #todo hafa ekki slug í kóða
    @instagram = A2::InstagramFeed.find_by_account_username('salomonsnowboards')

  end

  def contact
    page 'contact'
    render 'shared/basic_page'
  end

  def terms
    page 'terms'
    render 'shared/basic_page'
  end

  def privacy_policy
    page 'privacy_policy'
    render 'shared/basic_page'
  end

  def warranty
    page 'warranty'
    render 'shared/basic_page'
  end
end
