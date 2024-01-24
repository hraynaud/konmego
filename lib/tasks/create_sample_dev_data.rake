require 'pry'
require 'json'
require "#{Rails.root}/lib/sample_data/manager"

SAMPLE_DATA_ROOT_DIR = "#{Rails.root}/etc/sample_data".freeze

namespace :sample_data do # rubocop:disable Metrics/BlockLength
  desc 'create sample projects json file'
  namespace :create do # rubocop:disable Metrics/BlockLength
    desc 'populate dev db with sample data'
    task all: [:environment] do
      raise 'You cannot run this task in production' unless Rails.env.development?

      # clear_dev_data
      file_data = File.read("#{SAMPLE_DATA_ROOT_DIR}/category_topics_gpt.json")
      category_topic_data = JSON.parse(file_data)

      file_data = File.read("#{SAMPLE_DATA_ROOT_DIR}/users_gpt.json")
      user_data = JSON.parse(file_data)

      @users = []
      @topics = []
      @categories = []

      user_data.each do |u|
        @users << create_user(u)
      end

      category_topic_data.each do |category|
        create_category_topics(category)
      end

      # # sample endorsements
      # builder = RandomEndorsementBuilder.new(@users, @topics)
      # builder.build

      # sample projet
      builder = RandomProjectBuilder.new(@users, @topics)
      builder.build
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
  end
end
