class HomeController < ApplicationController
  def index
    page 'home'

    @vimeo = A2::VimeoFeed.latest_video
    team_categories = A2::TeamCategory.cached_deceandans_of(6)

    @team_categories_info =  team_categories.map {|c| {name: c.name,count: c.team_members.length}}
    @pro_team_members = team_categories.map {|c| c.team_members if c.slug == 'pros'}.first

    @instagram = A2::InstagramFeed.find_by_account_username('salomonsnowboards')
    @facebook = A2::FacebookFeed.where(:picture != nil).limit(2)

  end

  def contact
    page 'contact'
    render 'shared/basic_page'
  end

  def contact_ok
    page 'contact_ok'
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

  def faq
    page 'faq'
    render 'shared/basic_page'
  end
end
