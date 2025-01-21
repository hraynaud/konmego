require 'pry'
require 'json'
require "#{Rails.root}/lib/sample_data/manager"

SAMPLE_DATA_ROOT_DIR = "#{Rails.root}/etc/sample_data".freeze

namespace :db do # rubocop:disable Metrics/BlockLength
  namespace :dev do # rubocop:disable Metrics/BlockLength
    namespace :create do
      desc 'populate dev db with sample data'

      task all: [:environment] do
        raise 'You cannot run this task in production' unless Rails.env.development?

        Manager::Clean.all
        Manager.create_topics
        Manager.create_users
        Manager.create_projects
        Manager.create_endorsements
      end

      desc 'ceate users from sample user json'
      task users: [:environment] do
        Manager.create_users
      end

      desc 'ceate topics from sample category topics json'
      task topics: [:environment] do
        Manager.create_topics
      end

      desc 'ceate projects from sample project json'
      task projects: [:environment] do
        Manager.create_projects
      end

      desc 'ceate endorsments with existing users topics'
      task endorsements: [:environment] do
        Manager.create_endorsements
      end
    end

    namespace :clear do
      desc 'clear all data and relationships'
      task all: [:environment] do
        Manager::Clean.all
      end

      task users: [:environment] do
        Manager::Clean.users
      end

      task topics: [:environment] do
        Manager::Clean.topics
      end

      task endorsements: [:environment] do
        Manager::Clean.endorsements
      end

      task friendships: [:environment] do
        Manager::Clean.friendships
      end

      task projects: [:environment] do
        Manager::Clean.projects
      end
    end
  end
end
