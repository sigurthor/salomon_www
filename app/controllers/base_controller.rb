require 'open-uri'
class BaseController < ApplicationController
  include A2::ControllerHelpers::CMS

  helper :layout

  before_filter :set_locale


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

    if !(cookies[:country_code] and cookies[:continent_code] and cookies[:user_locale]) or params.key?(:ip) or cookies[:country_code].include?('INVALID_LICENSE_KEY')
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



end
