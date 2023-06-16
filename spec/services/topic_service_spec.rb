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
    before do
      @t = FactoryBot.create(:topic)
    end

    it "finds topic by name" do
      topic = TopicService.find_by_name(@t.name)
      expect(topic).to eq @t
    end

    it "finds topic by id" do
      topic = TopicService.get(@t.id)
      expect(topic).to eq @t
    end
  end

  describe ".find_or_create_by_name" do

    it "creates a new topic" do
      expect{ TopicService.find_or_create_by_name({name: "My topic"}) }.to change{Topic.count}.by(1)
    end

    it "doesn't recreate an existing  topic when passed name" do
      topic1 = FactoryBot.create(:topic)
      expect{ TopicService.find_or_create_by_name({name: topic1.name}) }.to change{Topic.count}.by(0)
    end

   it "returns the same object " do
     topic1 = FactoryBot.create(:topic)
     found = TopicService.get(topic1.id)
     expect(found.id).to eq(topic1.id)
   end
  end

end



