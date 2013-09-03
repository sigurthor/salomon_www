class HomeController < ApplicationController
  def index
    page 'home'


    if (stale?(:etag => create_etag([page.updated_at])))
      team_categories = A2::TeamCategory.cached_deceandans_of(6)
      @team_categories_info = team_categories.map { |c| {name: c.name, count: c.team_members.length} }
      @pro_team_members = team_categories.map { |c| c.team_members if c.slug == 'pros' }.first

      @vimeo = A2::VimeoFeed.cached_latest[0]
      @instagram = A2::InstagramFeed.cached_latest_by_user('salomonsnowboards')[0]
      @facebook = A2::FacebookFeed.cached_latest_with_photo[0..1]
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
