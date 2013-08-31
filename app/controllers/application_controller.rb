class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  after_filter :expire_http_cache

  def set_locale

    l = params[:locale] if params[:locale]

    I18n.locale = l || I18n.default_locale
  end


  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n #{I18n.locale}2"
    if (I18n.locale == :en)
      puts 'none'
      {}
    else
      puts 'other'
      {:locale => I18n.locale}
    end
  end

  def expire_http_cache
    headers['Last-Modified'] = Time.now.httpdate if Rails.env.frontend_development?
  end

  helper_method :page

  def page(pid = nil)
    pid = pid ? pid : current_uri = request.env['PATH_INFO']
    page = A2::Page.fetch_by_pid(pid)
    page = A2::Page.create(:pid => pid) unless page
    @Page ||= Rails.cache.fetch(page) { A2::Page.includes(:translations).find(page.id) }
  end

end
