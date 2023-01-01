
require 'pry'
require 'json'
require Rails.root.join("spec", "support","test_data_helper.rb")
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils
namespace :db do
  desc "load data"
  task :create_random_data => [:environment] do |task, args|


    raise "You cannot run this task in production" unless (Rails.env.development? || Rails.env.test?)
    clear_db

    topic_data = File.readlines("#{Rails.root}/spec/support/topics.txt", chomp: true)
    file = File.read("#{Rails.root}/spec/support/users.json")
    data = JSON.parse(file) #500 users
    user_data = data["results"]
    @users  = []
    @topics = []
    #real users
    user_data.each do |u|
     @users << create_user(u)
    end
    #real topics
    topic_data.each do |topic|
      @topics << FactoryBot.create(:topic, name: topic, default_image_file: "#{topic}.jpeg")
    end
    #pseudo endorsements
    builder = RandomEndorsementBuilder.new(@users,@topics)
    endorsements =  builder.build

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
  MAX_FRIENDS=20
  PseudoEndorsement = Struct.new(:from, :to, :topic, :status)

  def initialize users, topics
    @users = users
    @topics = topics
  end

  def build
    endorsements = []
    @users.each do |u|
      random_friends = rand(MAX_FRIENDS)
      for friend_idx in 0..random_friends-1 do
        endorsements << create_random_endorsement(u)
      end
    end
    endorsements
  end

  def create_random_endorsement u

    begin
    e =EndorsementService.create(u, {endorsee_id: random_user.id, topic_id: random_topic.id})
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
