require 'pry'
require Rails.root.join("spec", "support","test_data_helper.rb")
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils

namespace :db do
  desc "Creates sample data for development"
  task :create_dev_data   => [:environment] do |task, args|
    #probably not necessary since we set the env above
    Raise "You cannot run this task in any environment except development" unless Rails.env.development?

    clear_db
    setup_relationship_data
    setup_projects
  end


  task :clear_db   => [:environment] do |task, args|
    Raise "You cannot run this task in any environment except development" unless Rails.env.test?

    clear_db
  end

end


