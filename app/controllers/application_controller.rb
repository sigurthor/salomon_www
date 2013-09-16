require 'open-uri'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  after_filter :expire_http_cache

  rescue_from(ActionController::RoutingError) {
    render '/error/not_found', :layout => 'application'
  }

  def set_locale

    detect_location

    puts "country #{cookies[:country_code]} contient #{cookies[:continent_code]} locale #{cookies[:locale]}"

    l = params[:locale] if params[:locale]
    I18n.locale = l || I18n.default_locale
  end

  def detect_location
    if !(cookies[:country_code] and cookies[:continent_code] and cookies[:locale]) or params.key?(:ip)
      begin
        puts "ip set"
        ip = params.key?(:ip) ? params[:ip] : request.remote_ip
        country_code = open("https://geoip.maxmind.com/a?l=Xa0zTRtJOiE0&i=#{ip}").read
        country = A2::Country.find_by(:iso_code => country_code)
        continent = A2::CountryCodeContinent.find_by(:country_code => country_code).continent_code
        locale = country ? country.locale : 'en'
        set_location_cookies(country_code, continent, locale)
      rescue
        puts "ip fail"
        set_location_cookies('unknown', 'unknown', 'en')
      end
    end
  end

  def set_location_cookies(country_code, continent_code, locale)

    cookies[:country_code] = {value: country_code, expires: 10.days.from_now}
    cookies[:continent_code] = {value: continent_code, expires: 10.days.from_now}
    cookies[:locale] = locale

  end

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

  def page(pid = nil)
    return @page if @page
    pid = pid ? pid : current_uri = request.env['PATH_INFO']
    p = A2::Page.find_or_create_by(:pid => pid)
    @page ||= Rails.cache.fetch(p) { A2::Page.includes(:translations).find(p.id) }
  end

end
