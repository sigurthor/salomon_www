require 'open-uri'

class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :expire_http_cache
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n #{I18n.locale}2"
    if (I18n.locale == :en)
      {}
    else
      {:locale => I18n.locale}
    end
  end

  def expire_http_cache
    headers['Last-Modified'] = Time.now.httpdate if Rails.env.frontend_development? || Rails.env.development?
  end

  def create_etag(strings)
    strings << ENV["ETAG_VERSION_ID"]
    strings.join('')
  end


  helper_method :page

=begin
  def page(pid = nil)
    return @page if @page
    pid = pid ? pid : current_uri = request.env['PATH_INFO']
    p = A2::Page.find_or_create_by(:pid => pid)
    @page ||= Rails.cache.fetch(p) { A2::Page.includes(:translations).find(p.id) }
  end
=end

  helper_method :url_for_locale

  def url_for_locale(locale, setcountry=false)
    return '/' if locale.blank?
    main_app.url_for(params.merge!(:locale => locale).merge!(:only_path => true).except!(:ip, :set_country))
  end

end
