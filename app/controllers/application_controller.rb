class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

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
end
