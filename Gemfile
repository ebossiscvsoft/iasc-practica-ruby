source 'https://rubygems.org'
ruby '2.3.4'

gem 'sinatra'
gem 'sinatra-contrib'

gem 'multi_json', '~> 1.12.1'
gem 'rspec'

gem 'puma'

gem 'foreman'
gem "sinatra-sane-logging", require: "sinatra/sane_logging"
gem "json-schema"

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "pry"
  gem "pry-remote"
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
