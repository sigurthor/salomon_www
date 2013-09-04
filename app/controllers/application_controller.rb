class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  after_filter :expire_http_cache

  rescue_from(ActionController::RoutingError) {
    render '/error/not_found', :layout  => 'application'
  }

  def set_locale

    l = params[:locale] if params[:locale]

    I18n.locale = l || I18n.default_locale
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
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
    puts pid
    p = A2::Page.fetch_by_pid(pid)
    p = A2::Page.create(:pid => pid) unless p
    @page ||= Rails.cache.fetch(p) { A2::Page.includes(:translations).find(p.id) }
  end

end
