require 'open-uri'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  after_filter :expire_http_cache

  rescue_from(ActionController::RoutingError) {
    render '/error/not_found', :layout => 'application'
  }

  def set_locale

    if params[:set_country]
      cookies[:show_bar] = 0
      cookies[:user_locale] = params[:set_country]
      redirect_to url_for_locale(params[:set_country])
    end

    l = params[:locale] if params[:locale]
    I18n.locale = l || 'en'
    cookies[:current_locale] = I18n.locale

    redirect

    puts "country #{cookies[:country_code]} contient #{cookies[:continent_code]} locale #{cookies[:user_locale]}"
    puts "#{params[:locale]} locale param #{cookies[:locale]}"
  end

  def detect_user

    if !(cookies[:country_code] and cookies[:continent_code] and cookies[:user_locale]) or params.key?(:ip)
      begin
        ip = params.key?(:ip) ? params[:ip] : request.remote_ip
        country_code = open("https://geoip.maxmind.com/a?l=Xa0zTRtJOiE0&i=#{ip}").read
        country_code = 'global' if country_code.include?('IP_NOT_FOUND')
        country = A2::Country.find_by(:iso_code => country_code)
        continent = A2::CountryCodeContinent.find_by(:country_code => country_code).try(:continent_code)
        locale = country ? country.locale : 'en'
        set_location_cookies(country_code, continent, locale)
      rescue
        set_location_cookies('global', '', 'en')
      end
      cookies[:show_bar] = 1
    end
  end

  def redirect
    detect_user
    if 'en'.casecmp(I18n.locale.to_s).zero?
      redirect_to url_for_locale(cookies[:user_locale]) unless cookies[:user_locale].casecmp(I18n.locale.to_s).zero?
    end
  end

  def set_location_cookies(country_code, continent_code, locale)
    cookies[:country_code] = {value: country_code, expires: 10.days.from_now}
    cookies[:continent_code] = {value: continent_code, expires: 10.days.from_now}
    cookies[:user_locale] = {value: locale, expires: 10.days.from_now}
  end

  helper_method :url_for_locale

  def url_for_locale(locale, setcountry=false)
    return '/' if locale.blank?
    url_for(params.merge!(:locale => locale).merge!(:only_path => true).except!(:ip, :set_country))
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
