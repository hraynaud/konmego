require 'set'
require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Utils

describe TopicSearchService do
  before(:all) do
    clear_db
    setup_relationship_data
  end

  after(:all) do
    clear_db
  end

  describe ".get_graph_elements" do

    it "finds subgraph from person by topic" do
      results = TopicSearchService.search_endorsing_contacts @herby, "Cooking"
      expect_result_data_to_match_expected( results, [@tisha, @fauzi])
    end

    it "finds inidrect contacts that have endorsed the topic" do
      results = TopicSearchService.search_endorsing_contacts @fauzi, "Singing"
      expect_result_data_to_match_expected( results, [@tisha])
    end

    it "ignores self when search for contacts that have endorsed the topic" do
      results = TopicSearchService.search_endorsing_contacts @fauzi, "Cooking"
      expect_result_data_to_match_expected( results, [@tisha])
    end

    it "finds direct and indirect contacts that have endorsed the topic with specified number of hops " do
      results = TopicSearchService.search_endorsing_contacts @sar, "Singing"
      expect_result_data_to_match_expected( results, [@tisha])
    end

   it "doesn't find contacts that have endorsed the topic if outside of allowed number of hops " do
      results = TopicSearchService.search_endorsing_contacts @sar, "Singing", 2
      expect_result_data_to_match_expected( results, [])
    end

  end

end

def expect_result_data_to_match_expected query_data, expected
  expect(query_data.to_set).to eq expected.to_set
end



