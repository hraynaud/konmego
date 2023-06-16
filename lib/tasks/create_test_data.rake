require 'pry'
require Rails.root.join("spec", "support","test_data_helper.rb")
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils

namespace :db do
  namespace :test do 
  desc "Creates sample data for test"
  task :create_test_data   => [:environment] do |task, args|
    #probably not necessary since we set the env above
    raise "You cannot run this task in production" unless (Rails.env.development? || Rails.env.test?)

    clear_db
    setup_relationship_data
    setup_projects
  end


  task :clear_db   => [:environment] do |task, args|
    raise "You cannot run this task in production" unless  (Rails.env.development? || Rails.env.test?)
    clear_db
  end
end

end


