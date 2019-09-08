require 'set'
require 'rails_helper'
include TestDataHelper::Relationships

describe TopicSearchService do
  before(:all) do
    setup_relationship_data
  end

  after(:all) do
    clear_db
  end

  describe ".find_contacts_connected_to_topic_for" do
    it "finds skill through contacts" do
      expect(TopicSearchService.find_contacts_connected_to_topic_for(@fauzi, "Singing").to_set).to eq [@tisha].to_set
    end

    it "finds skill directly and through contacts" do
      expect(TopicSearchService.find_contacts_connected_to_topic_for(@fauzi, "Cooking").to_set).to eq [@fauzi, @tisha].to_set
    end

    it "finds skill through arbitrary number of contacts" do
      expect(TopicSearchService.find_contacts_connected_to_topic_for(@sar, "Singing", 3)).to eq [@tisha]
    end

    it "doesn't find skill if skill outside of hops limit" do
      expect(TopicSearchService.find_contacts_connected_to_topic_for(@sar, "Singing", 2)).to eq []
    end

  end

end
