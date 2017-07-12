source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby '2.4.0'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
#jquery for rails
gem 'jquery-rails'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#disabled due to reload issues
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
#datetime picker
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
#devise user authentication with twitter/facebook integration
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'

group :development, :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  #use pry for debugging
  gem 'pry-rails'
  #user rspec instead of minitest
  gem 'rspec-rails'
  gem 'valid_attribute'
  gem 'factory_girl_rails'
  gem 'coffee-rails'
  #support for javascript spec testing
  gem 'teaspoon-jasmine'
  gem 'launchy', require: false
  #handles environment variables in .env
  gem 'dotenv-rails'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
