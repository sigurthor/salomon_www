class RackAssetsFilter
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    puts env
    puts env['PATH_INFO']
    if env['REQUEST_PATH'].starts_with?("/assets/webfonts")
      puts "add origin"
      headers['Access-Control-Allow-Origin'] = '*'
      # ...
    end
    [status, headers, body]
  end
end
