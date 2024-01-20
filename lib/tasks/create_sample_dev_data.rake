require 'pry'
require 'json'
# require Rails.root.join('spec', 'support', 'dev_data_helper.rb')

namespace :db do
  desc 'load data'
  task create_sample_data: [:environment] do
    raise 'You cannot run this task in production' unless Rails.env.development?

    # clear_dev_data
    file_data = File.read("#{Rails.root}/spec/support/category_topics_gpt.json")
    category_topic_data = JSON.parse(file_data)

    file_data = File.read("#{Rails.root}/spec/support/users_gpt.json")
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

    binding.pry
    # # sample endorsements
    # builder = RandomEndorsementBuilder.new(@users, @topics)
    # builder.build

    # # sample projet
    # builder = RandomProjectBuilder.new(@users, @topics)
    # builder.build
  end
end

def clear_dev_data
  clear_topics
  clear_endorsments
  clear_identities
  clear_projects
  clear_topics
  clear_users
end

def create_user(user)
  FactoryBot.build(
    :person,
    first_name: user['firstName'],
    last_name: user['lastName'],
    bio: user['bio'],
    profile_image_url: user['picture']['large'],
    avatar_url: user['picture']['thumbnail']
  )
end

def create_category_topics(category)
  @categories << category['category']
  category['topics'].each do |payload|
    next if @topics.include? payload['topic']

    @topics << FactoryBot.build(:topic, name: payload['topic'],
                                        icon: payload['icon'],
                                        default_image_file: "#{payload['topic']}.jpeg")
  end
end

def clear_topics
  ActiveGraph::Base.query('MATCH (n:Topic) DETACH DELETE n')
end

def clear_users
  ActiveGraph::Base.query('MATCH (n:Person) DETACH DELETE n')
end

def clear_endorsments
  ActiveGraph::Base.query('MATCH (n:Endorsement) DETACH DELETE n')
end

def clear_identities
  ActiveGraph::Base.query('MATCH (n:Identity) DETACH DELETE n')
end

def clear_projects
  ActiveGraph::Base.query('MATCH (n:Project) DETACH DELETE n')
end

# class RandomEndorsementBuilder
#   MAX_ENDORSEMENTS = 3

#   def initialize(users, topics)
#     @users = users
#     @topics = topics
#   end

#   def build
#     @users.each do |u|
#       endorsements_to_create = rand(MAX_ENDORSEMENTS + 1)

#       while endorsements_to_create.positive?
#         create_sample_endorsement(u)
#         endorsements_to_create -= 1
#       end
#     end
#   end

#   def create_sample_endorsement(u)
#     @accepted = []
#     @pending = []
#     begin
#       do_accept(u, random_user, random_topic)
#     rescue ActiveGraph::Node::Persistence::RecordInvalidError
#       # no op
#     end
#   end

#   def random_user
#     @users[rand(@users.count)]
#   end

#   def random_topic
#     @topics[rand(@topics.count)]
#   end
# end

# class RandomProjectBuilder
#   MAX_PROJECTS = 4

#   DESCRIPTION_INTRS = [
#     'Trying to learn all abou ...', 'Witing a book about ...', 'Need to find experts the field of ...',
#     'Starting a company that focus on ...', 'Looking to sell my vintage collection ... memoriabilia'
#   ].freeze

#   PseudoProject = Struct.new(:name, :description)

#   def initialize(users, topics)
#     @users = users
#     @topics = topics
#   end

#   def build
#     projects = []
#     @users.each do |u|
#       @topics_used = []
#       projects_to_create = rand(MAX_PROJECTS + 1)

#       while projects_to_create.positive?

#         topic = get_unused_topic
#         projects << create_sample_project(u, topic)
#         projects_to_create -= 1

#       end
#     end
#   end

#   def get_unused_topic
#     topic = random_topic

#     topic = random_topic while @topics_used.include? topic

#     @topics_used << topic
#     topic
#   end

#   def create_sample_project(user, topic)
#     project = ProjectService.create(user,
#                                     { name: "#{user.name}-#{topic.name}", description: 'this is a cool project',
#                                       visibility: :friends })
#     project.topic = topic
#     project.save
#   rescue ActiveGraph::Node::Persistence::RecordInvalidError
#     # no op
#   end

#   def random_user
#     @users[rand(@users.count)]
#   end

#   def random_topic
#     @topics[rand(@topics.count)]
#   end
#
