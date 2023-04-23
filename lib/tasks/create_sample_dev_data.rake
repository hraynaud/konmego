require 'pry'
require 'json'
require Rails.root.join("spec", "support","test_data_helper.rb")
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils
namespace :db do
  desc "load data"
  task :create_sample_data => [:environment] do


    raise "You cannot run this task in production" unless (Rails.env.development? || Rails.env.test?)
    clear_db

    topic_data = File.readlines("#{Rails.root}/spec/support/topics.txt", chomp: true)
    file = File.read("#{Rails.root}/spec/support/users.json")
    data = JSON.parse(file) #500 users
    user_data = data["results"]
    @users  = []
    @topics = []
    #sample users
    user_data.each do |u|
     @users << create_user(u)
    end
    #sample topics
    topic_data.each do |topic|
      @topics << FactoryBot.create(:topic, name: topic, default_image_file: "#{topic}.jpeg")
    end
    #sample endorsements
    builder = RandomEndorsementBuilder.new(@users,@topics)
    builder.build

     #sample projet
     builder = RandomProjectBuilder.new(@users,@topics)
     builder.build

  end

end

def create_user user
  FactoryBot.create(
    :person,
    identity: FactoryBot.create(:identity, 
                                first_name: user["name"]["first"], 
                                last_name: user["name"]["last"]
                               ),
    profile_image_url: user["picture"]["large"],
    avatar_url: user["picture"]["thumbnail"],
  )
end

class RandomEndorsementBuilder
  MAX_ENDORSEMENTS = 3

  def initialize users, topics
    @users = users
    @topics = topics
  end

  def build
    @users.each do |u|
      endorsements_to_create = rand(MAX_ENDORSEMENTS + 1 )

      while endorsements_to_create > 0 do
        create_sample_endorsement(u)
        endorsements_to_create -= 1
      end 
    end
  end

  def create_sample_endorsement u

    begin
    e = EndorsementService.create(u, {endorsee_id: random_user.id, topic_id: random_topic.id})
    EndorsementService.accept(e)
    rescue ActiveGraph::Node::Persistence::RecordInvalidError
      #no op
    end
  end

  def random_user
    @users[rand(@users.count)]
  end

  def random_topic
    @topics[rand(@topics.count)]
  end
end


class RandomProjectBuilder
  MAX_PROJECTS = 4

  PseudoProject = Struct.new(:name, :description)

  def initialize users, topics
    @users = users
    @topics = topics
  end

  def build
    projects = []
    @users.each do |u|
      @topics_used = []
      projects_to_create = rand(MAX_PROJECTS + 1 )

      while projects_to_create > 0  do

       topic = get_unused_topic
        projects << create_sample_project(u, topic)
        projects_to_create -= 1
        
      end
    end
  end

  def get_unused_topic 
    topic = random_topic 
        
    while @topics_used.include? topic
      topic = random_topic   
    end

    @topics_used  << topic
    topic
  end 

  def create_sample_project(user, topic)

    begin
      project = ProjectService.create(user, {name: "#{user.name}-#{topic.name}", description: "this is a cool project", visibility: :friends})
      project.topic = topic
      project.save
    rescue ActiveGraph::Node::Persistence::RecordInvalidError
      #no op
    end
  end

  def create_sample_endorsement u

    begin
    e = EndorsementService.create(u, {endorsee_id: random_user.id, topic_id: random_topic.id})
    EndorsementService.accept(e)
    rescue ActiveGraph::Node::Persistence::RecordInvalidError
      #no op
    end
  end

  def random_user
    @users[rand(@users.count)]
  end

  def random_topic
    @topics[rand(@topics.count)]
  end
end