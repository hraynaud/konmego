require 'set'
require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Utils

describe TopicCreationService do
  before(:all) do
    clear_db
  end

  after(:all) do
  end

  describe ".create" do

    it "creates a new topic" do
      expect{ TopicCreationService.create({name: "My topic"}) }.to change{Topic.count}.by(1)
    end

  end

end



