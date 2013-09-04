class HomeController < ApplicationController
  def index
    page 'home'
    puts "#{Cashier.tags} tags"

    tc = A2::TeamCategory.cached_deceandans_of('salomon')
    @team_categories_info = tc.map { |c| {name: c.name, count: c.team_members.length} }
    @pro_team_members = tc[tc.index { |c| c.slug == 'pros' }].team_members

    @vimeo = A2::VimeoFeed.cached_latest
    @instagram = A2::InstagramFeed.cached_latest_by_user('salomonsnowboards')
    @facebook = A2::FacebookFeed.cached_latest_with_limit(2)

    respond_to do |f|
      f.html
    end

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
