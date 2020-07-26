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

  describe ".paths_to_resource" do

    context "root node is endorser or endorser is in friend chain between the root node and endorsee" do

      it "returns path for topic directly endorsed by person " do
        #------------------------------------------------------------------------------
        #fauzi -- ENDORSES('Cooking') --> franky ( A--> KNOWS & ENDORSES -->B )
        #------------------------------------------------------------------------------
        results = TopicSearchService.paths_to_resource @fauzi, "Cooking", 0
        expect_result_data_to_match_expected( results, [[@fauzi]])
        #expect(results.map(:endorsment)).to not_be nil
      end

      it "returns path for topic endorsed indirectly through direct contact" do
        #------------------------------------------------------------------------------
        # herby -- KNOWS --> tisha --> ENDORSES('Composer') --> Person
        #  ( A--> KNOWS -->B KNOWS & ENDORSES --> C)
        #------------------------------------------------------------------------------
        results = TopicSearchService.paths_to_resource @herby, "Composer",1
        expect_result_data_to_match_expected( results, [[@herby, @tisha]])
      end

      it "doesn't find path if min distance it too short" do
        #------------------------------------------------------------------------------
        # fauzi --> KNOWS --> franky --> (herby:hidden) --> KNOWS --> (tisha:hidden)  ENORSES --> (kendra:NOT_RETURNED)
        #------------------------------------------------------------------------------
        results = TopicSearchService.paths_to_resource @fauzi, "Singing", 2
        expect_result_data_to_match_expected( results, empty_set)
      end

      it "finds path to contacts within default distance = 3" do
        #------------------------------------------------------------------------------
        # fauzi --> KNOWS --> franky --> (herby:hidden) --> KNOWS --> (tisha:hidden)  ENORSES --> (kendra:NOT_RETURNED)
        #------------------------------------------------------------------------------
        results = TopicSearchService.paths_to_resource @fauzi, "Singing"
        expect_result_data_to_match_expected( results, [[@fauzi, @franky, @hidden, @hidden]])
      end

      it "finds path to contacts that have endorsed the topic by depth" do
        results = TopicSearchService.paths_to_resource @elsa, "Singing", 4
        expect_result_data_to_match_expected( results, [[@elsa, @sar, @hidden, @hidden, @hidden ]])
      end

    end



    context "endorser is NOT part of continous friend chain from root node" do

      it "finds path if depth param exceeds actual distance to endorser node by at least 1" do
        #------------------------------------------------------------------------------
        #elsa -- KNOWS --> sar <-- ENORSED_BY -- (jean:hidden) (elsa !KOWS jean)
        #elsa -- KNOWS --> sar <-- ENORSED_BY -- (nuno:hidden) (elsa !KOWS nuno)
        #elsa -- KNOWS --> sar -> ENORSES(djing) --> (jerry:hidden) 

        #------------------------------------------------------------------------------
        results = TopicSearchService.paths_to_resource @elsa, "Djing", 2
        expect_result_data_to_match_expected( results, [[@elsa, @sar],[@elsa, @sar, @hidden]])

        #------------------------------------------------------------------------------
        # tish --> KNOWS --> herby --> KNOWS --> franky <-- ENORSED_BY -- (fauzi:hidden) (herby !KOWS fauzi)
        #  ( A--> KNOWS -->B --> KNOWS C --> KNOWS & IS ENORSED_BY --> D)
        #------------------------------------------------------------------------------
        results = TopicSearchService.paths_to_resource @tisha, "Cooking", 3
        expect_result_data_to_match_expected( results, [[@tisha, @herby,  @hidden, @hidden]])
      end

      context "multiple paths to endorsee" do

        it "doesn't include routes exceeding max distance" do
          results = TopicSearchService.paths_to_resource @kendra, "Cooking",4
          expect_result_data_to_match_expected( results, [
            [@kendra, @tisha, @hidden, @hidden, @hidden]
          ])
        end

        it "finds all routes satisfying max distance" do
          results = TopicSearchService.paths_to_resource @kendra, "Cooking",5
          expect_result_data_to_match_expected( results, [
            [@kendra, @tisha, @hidden, @hidden, @hidden],
            [@kendra, @vince, @tisha, @hidden, @hidden, @hidden]
          ])
        end
      end

    end

    context "mixed direct and indirect path to endorser" do
      it "does a mixed thing" do
        #------------------------------------------------------------------------------
        # nuno --> ENDORSES sar(:djing) 
        # nuno --> KONWS --> gilbert --> KNOWS --> jean(:hidden) -->ENDORSES sar(:djing) 
        # numo --> KNOWS --> sar <-- KNOWS & IS_ENDORSED_BY(:djing) -- jean(:hidden)
        #
        results = TopicSearchService.paths_to_resource @nuno, "Djing"
        expect_result_data_to_match_expected( results, [[@nuno], [@nuno, @gilbert, @hidden ], [@nuno, @gilbert, @hidden, @sar ],[@nuno, @sar ], [@nuno, @sar, @hidden ]])
      end

      it "doesn't show circular references routes when endorser endorsed directly and reachable through friend path" do

        #------------------------------------------------------------------------------
        # [["Tisha Skillz"]]
        #------------------------------------------------------------------------------

        results = TopicSearchService.paths_to_resource @tisha, "Composer"
        expect_result_data_to_match_expected( results, [[@tisha ]])
      end
    end

  end

 pending "validate graph structure"

 
     #expect(data["nodes"].size).to eq sars_cooking_network["nodes"].size
     #expect(data["links"].size).to eq sars_cooking_network["links"].size
     #validate_relationship_types data, sars_cooking_network
     #validate_node_types data, sars_cooking_network

 def validate_node_types data, expected
   ["Person","Endorsement","Topic"].each do |type| 
     expect( node_type_count(data, type)).to eq node_type_count(expected, type)
   end
 end

 def validate_relationship_types data, expected
   ["KNOWS","ENDORSEMENT_SOURCE","ENDORSE_TOPIC"].each do |type| 
     expect( link_type_count(data, type)).to eq link_type_count(expected, type)
   end
 end

 def link_type_count link_data, type
   link_data["links"].select{|l|l["type"] == type}.size
 end

 def node_type_count node_data, type
   node_data["nodes"].select{|l|l["type"] == type}.size
 end
end

def expect_result_data_to_match_expected results, expected
  paths =  results.map{|x|x[:path]}
  result_names = results.map{|res|res[:path].map{|p|p[:name]}}
  expected_names =  expected.map{|path|path.map(&:name)}
  expect(result_names.to_set).to match_array expected_names.to_set
end



