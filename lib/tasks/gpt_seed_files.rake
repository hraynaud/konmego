require 'pry'
require 'json'
require "#{Rails.root}/lib/sample_data/utils/open_ai_assistant"
require "#{Rails.root}/lib/sample_data/utils/gpt_seeder"

# SAMPLE_DATA_ROOT_DIR = "#{Rails.root}/etc/sample_data".freeze

namespace :gpt do
  namespace :seed do
    desc 'create sample projects json file'

    task projects: [:environment] do
      raise 'You cannot run this task in production' unless Rails.env.development?

      GptSeeder.seed_projects
    end

    task endorsements: [:environment] do
      raise 'You cannot run this task in production' unless Rails.env.development?

      GptSeeder.seed_endorsements
    end
  end
end
