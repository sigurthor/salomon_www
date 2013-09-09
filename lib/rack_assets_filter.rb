class RackAssetsFilter
  def initialize(app)
    @app = app
  end

  def call(env)
    [status, headers, body] = @app.call env
    if env['PATH_INFO'].starts_with("/assets/")
      headers['X-Header-bubu'] = 'sigurthor'
      # ...
    end
    return [status, headers, body]
    env
  end
end
