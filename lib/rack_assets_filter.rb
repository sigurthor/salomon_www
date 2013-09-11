class RackAssetsFilter
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    if env['REQUEST_PATH'].starts_with?("/assets/webfonts")
      headers['Access-Control-Allow-Origin'] = '*'
    end
    [status, headers, body]
  end
end
