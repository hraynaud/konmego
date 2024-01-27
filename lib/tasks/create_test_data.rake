require 'pry'
require Rails.root.join("spec", "support","test_data_helper.rb")
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils
ERROR = "You can only run this taks in test".freeze
namespace :db do
  namespace :test do
  desc "Creates sample data for test"
  task :populate   => [:environment] do |task, args|
    #probably not necessary since we set the env above
    raise ERROR = "You can only run this taks in test".freeze
    unless (Rails.env.test?)

    clear_db
    setup_relationship_data
    setup_projects
  end


  task :clear_db   => [:environment] do |task, args|
    raise ERROR unless  (Rails.env.test?)
    clear_db
  end
end

end
