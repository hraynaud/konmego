require 'set'
require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Utils

describe EndorsementSearchService do
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
        results = EndorsementSearchService.paths_to_resource @fauzi, "Cooking", 0
        expect_result_data_to_match_expected( results, [[@fauzi]])
        #expect(results.map(:endorsment)).to not_be nil
      end

      it "returns path for topic endorsed indirectly through direct contact" do
        #------------------------------------------------------------------------------
        # herby -- KNOWS --> tisha --> ENDORSES('Composer') --> Person
        #  ( A--> KNOWS -->B KNOWS & ENDORSES --> C)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @herby, "Composer",1
        expect_result_data_to_match_expected( results, [[@herby, @tisha]])
      end

      it "doesn't find path if min distance it too short" do
        #------------------------------------------------------------------------------
        # fauzi --> KNOWS --> franky --> (herby:hidden) --> KNOWS --> (tisha:hidden)  ENDORSES --> (kendra:NOT_RETURNED)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @fauzi, "Singing", 2
        expect_result_data_to_match_expected( results, empty_set)
      end

      it "finds path to contacts within default distance = 3" do
        #------------------------------------------------------------------------------
        # fauzi --> KNOWS --> franky --> KNOWS --> (herby:hidden) --> KNOWS --> (tisha:hidden)  ENDORSES --> (kendra:NOT_RETURNED)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @fauzi, "Singing"
        expect_result_data_to_match_expected( results, [[@fauzi, @franky, @hidden, @hidden]])
      end


      it "finds path to contacts that have endorsed the topic by depth" do
        #------------------------------------------------------------------------------
         results = EndorsementSearchService.paths_to_resource @elsa, "Basketball", 5
         expect_result_data_to_match_expected( results, [[@elsa, @sar, @hidden, @hidden, @hidden, @hidden ]])
       end

      it "finds multiple path to contacts that have endorsed the topic by specified depth" do
     
       # ------------------------------------------------------------------------------
       # PATH 1
       # ["Elsa Skillz", "Sar Skillz", "Kendra Skillz", "Vince Skillz", "Tisha Skillz"]
       #------------------------------------------------------------------------------

       #------------------------------------------------------------------------------
       #  PATH 2
       # ["Elsa Skillz", "Sar Skillz", "Franky Skillz", "Herby Skillz", "Tisha Skillz"]
       #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @elsa, "Singing", 4
        expect_result_data_to_match_expected( results, [[@elsa, @sar, @hidden, @hidden, @hidden ],[@elsa, @sar, @hidden , @hidden]])
      end

     

    end



    context "endorser is NOT part of continous friend chain from root node" do

      it "finds all paths to endorsee if depth is sufficent" do
        #------------------------------------------------------------------------------
        #elsa -- KNOWS --> sar <-- ENDORSED_BY -- (jean:hidden) (elsa !KOWS jean)
        #elsa -- KNOWS --> sar <-- ENDORSED_BY -- (nuno:hidden) (elsa !KOWS nuno)
        #elsa -- KNOWS --> sar -> ENDORSES(djing) --> (jerry:hidden) 

        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @elsa, "Djing", 2
        #NOTE TODO
        # because of obfuscation this path is show 1 but should be show twice [@elsa, @sar, @hidden]
        expect_result_data_to_match_expected( results, [[@elsa, @sar],[@elsa, @sar, @hidden]])

      end


      it "finds path if depth param exceeds actual distance to endorser node by at least 1" do
     
        #------------------------------------------------------------------------------
        # tish --> KNOWS --> herby --> KNOWS --> franky <-- ENORSED_BY -- (fauzi:hidden) (herby !KOWS fauzi)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @tisha, "Cooking", 3
        expect_result_data_to_match_expected( results, [[@tisha, @herby,  @hidden, @hidden]])
      end

      context "multiple paths to endorsee" do

        it "doesn't include routes exceeding max distance" do
        #------------------------------------------------------------------------------
        # Kendra --> KNOWS --> tisha --> KNOWS --> Herby --> franky <-- ENORSED_BY -- (fauzi:hidden) 
        #------------------------------------------------------------------------------
        #------------------------------------------------------------------------------
        # Kendra --> KNOWS --> sar --> KNOWS --> Franky <-- ENORSED_BY -- (fauzi:hidden) 
        #------------------------------------------------------------------------------
     
          results = EndorsementSearchService.paths_to_resource @kendra, "Cooking",4
          expect_result_data_to_match_expected( results, [
            [@kendra, @tisha, @hidden, @hidden, @hidden],
            [@kendra, @sar, @hidden, @hidden]
          ])
        end

        it "finds all routes satisfying max distance" do

          #["Kendra Skillz", "Vince Skillz", "Tisha Skillz", "Herby Skillz", "Franky Skillz", "Fauzi Skillz"]#
          #["Kendra Skillz", "Sar Skillz", "Franky Skillz", "Fauzi Skillz"]
          #["Kendra Skillz", "Tisha Skillz", "Herby Skillz", "Franky Skillz", "Fauzi Skillz"]

          results = EndorsementSearchService.paths_to_resource @kendra, "Cooking",5
          expect_result_data_to_match_expected( results, [
            [@kendra, @tisha, @hidden, @hidden, @hidden],
            [@kendra, @sar, @hidden, @hidden],
            [@kendra, @vince, @tisha, @hidden, @hidden, @hidden],
          
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
        results = EndorsementSearchService.paths_to_resource @nuno, "Djing"
        expect_result_data_to_match_expected( results, [[@nuno], [@nuno, @gilbert, @hidden ], [@nuno, @gilbert, @hidden, @sar ],[@nuno, @sar ], [@nuno, @sar, @hidden ]])
      end

      it "doesn't show circular references routes when endorser endorsed directly and reachable through friend path" do

        #------------------------------------------------------------------------------
        # [["Tisha Skillz"]]
        #------------------------------------------------------------------------------

        results = EndorsementSearchService.paths_to_resource @tisha, "Composer"
        expect_result_data_to_match_expected( results, [[@tisha ]])
      end
    end

  end

end

def expect_result_data_to_match_expected results, expected

  result_names = results.map{|res|res[:path].map{|p|p[:name]}}
  expected_names =  expected.map{|path|path.map(&:name)}
  expect(result_names.to_set).to match_array expected_names.to_set
end



