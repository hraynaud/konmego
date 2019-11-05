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
      results = TopicSearchService.paths_to_resource @herby, "Cooking"
      expect_result_data_to_match_expected( results, [
        [@herby,  @tisha],
        [@herby, @fauzi]
      ])
    end


    it "it only finds indirect path to skill even if the endorsement target is a direct contact" do
      obfuscator = Obfuscator.new(@elsa) 
      results = TopicSearchService.paths_to_resource @elsa, "Djing"
      expect_result_data_to_match_expected( results, [[@elsa, @sar, obfuscator.obfuscate(@jean)]])
    end

    context "user is @sar" do

      let(:obfuscator) {Obfuscator.new(@sar)}

      it "finds subgraph from person by topic" do
        results = TopicSearchService.paths_to_resource @sar, "Cooking"
        expect_result_data_to_match_expected( results, [
          [@sar, @elsa, obfuscator.obfuscate(@herby), obfuscator.obfuscate(@tisha)],
          [@sar, @elsa,obfuscator.obfuscate(@herby), obfuscator.obfuscate(@fauzi)]
        ])
      end

      it "finds direct and indirect contacts that have endorsed the topic with specified number of hops " do
        results = TopicSearchService.paths_to_resource @sar, "Singing"
        expect_result_data_to_match_expected( results, [[@sar, @elsa, obfuscator.obfuscate(@herby), obfuscator.obfuscate(@tisha)]])
      end

      it "doesn't find contacts that have endorsed the topic if outside of allowed number of hops " do
        results = TopicSearchService.paths_to_resource @sar, "Singing", 2
        expect_result_data_to_match_expected( results, [])
      end

    end

    context "user is @fauzi" do

      let(:obfuscator) {Obfuscator.new(@fauzi)}

      it "finds indirect contacts that have endorsed the topic" do
        results = TopicSearchService.paths_to_resource @fauzi, "Singing"
        expect_result_data_to_match_expected( results, [[@fauzi, @herby, obfuscator.obfuscate(@tisha)]])
      end

      it "returns path containing root user root has endorsement for topic" do
        results = TopicSearchService.paths_to_resource @fauzi, "Cooking"
        expect_result_data_to_match_expected( results, [[@fauzi], [@fauzi, @herby, obfuscator.obfuscate(@tisha)]])
      end
    end


  end

end

def expect_result_data_to_match_expected query_data, expected
  expect(query_data.to_set).to match_array expected.to_set
end



