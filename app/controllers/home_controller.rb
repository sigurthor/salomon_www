class HomeController < ApplicationController
  def index
    page 'home'
    puts "#{Cashier.tags} tags"

    c = A2::TeamCategory.fetch_by_slug_and_type('pros','A2::TeamCategory')
    @pro_team_members = Rails.cache.fetch(c.updated_at) { c.team_members.all }

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
