source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'bcrypt', '~> 3.1.7'

# gem 'bootsnap', '>= 1.1.0', require: false
gem 'activegraph', '11.5.0.beta.3' # For example, see https://rubygems.org/gems/activegraph/versions for the latest versions
gem 'delayed_job_active_record'
gem 'jsonapi-serializer'
gem 'jwt'
gem 'langchainrb'
gem 'neo4j-ruby-driver'
gem 'oauth'
gem 'ollama-ai', '~> 1.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 5.6'
gem 'rack-cors'
gem 'rails', '~>7.1'
gem 'rspec-mocks'
gem 'rubyzip', '2.3.0'
gem 'set', '1.1.0'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'letter_opener'
  gem 'neo4j-rake_tasks'
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rubocop'
end

group :development do
  gem 'listen' # , '>= 3.0.5', '< 3.2'
end
