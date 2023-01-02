source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~>7.0' 
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'bcrypt', '~> 3.1.7'
#gem 'bootsnap', '>= 1.1.0', require: false
gem 'rack-cors'
gem 'oauth'
gem 'jwt'
gem 'activegraph', '~> 10.1.0' # For example, see https://rubygems.org/gems/activegraph/versions for the latest versions
gem 'neo4j-ruby-driver'#, '~> 1.7.0'
gem 'delayed_job_active_record'
gem 'jsonapi-serializer'
gem 'rubyzip', '2.3.0'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_bot' 
  gem "factory_bot_rails"
  gem "neo4j-rake_tasks"
  gem "faker"
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end

