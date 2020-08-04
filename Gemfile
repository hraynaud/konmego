source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rack-cors'
gem 'oauth'
gem 'jwt'
#gem 'neo4j', '~> 9.2.0'
gem 'activegraph', '~> 10.0.0' # For example, see https://rubygems.org/gems/activegraph/versions for the latest versions
gem 'neo4j-ruby-driver', '~> 1.7.0'
gem 'fast_jsonapi'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_bot' 
  gem "factory_bot_rails"
  gem "neo4j-rake_tasks"
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end

