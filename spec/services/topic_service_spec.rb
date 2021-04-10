require 'set'
require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Utils

describe TopicService do
  before(:all) do
    clear_db
  end

  after(:all) do
  end

  describe ".get" do

    it "creates a new topic" do
      expect{ TopicService.get({name: "My topic"}) }.to change{Topic.count}.by(1)
    end

    it "doesn't recreate an existing  topic when passed name" do
      topic1 = FactoryBot.create(:topic)
      expect{ TopicService.get({name: topic1.name}) }.to change{Topic.count}.by(0)
    end

   it "doesn't create new topic when passed existing id " do
      topic1 = FactoryBot.create(:topic)
      expect{ TopicService.get({topic_id: topic1.id}) }.to change{Topic.count}.by(0)
      expect{ TopicService.get({topic_id: topic1.id}) }.to change{Topic.count}.by(0)
    end
   it "doesn't create new topic when passed existing id " do
     topic1 = FactoryBot.create(:topic)
     expect{ TopicService.get({topic_id: topic1.id}) }.to change{Topic.count}.by(0)
   end

   it "returns the same object " do
     topic1 = FactoryBot.create(:topic)
     found = TopicService.get({topic_id: topic1.id})
     expect(found.id).to eq(topic1.id)
   end

    #it "raises TopicError neither topic_id or name is provided" do
      #topic1 = FactoryBot.create(:topic)
      #expect{ TopicService.get({name: topic1.name}) }.to change{Topic.count}.by(0)
    #end
  end

end



