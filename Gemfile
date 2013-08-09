source 'https://rubygems.org'


gem 'rails', '3.2.14'
gem 'mysql2'


if (File.directory?('../A2'))
  gem 'a2', path: '../A2'
else
  gem 'a2', git: 'https://github.com/sigurthor/a2_backend.git'
end


group :assets, :frontend_development do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails' # you need this or you get an err
  gem 'zurb-foundation', '~> 4.0.0'
end

gem 'jquery-rails'


# Use unicorn as the app server
# gem 'unicorn'

# To use debugger
# gem 'debugger'
