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

  describe '.paths_to_resource' do
    context 'root node is endorser or endorser is in friend chain between the root node and endorsee' do
      it 'returns path for topic directly endorsed by person ' do
        #------------------------------------------------------------------------------
        # fauzi -- ENDORSES('Cooking') --> franky ( A--> KNOWS & ENDORSES -->B )
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @fauzi, 'Cooking', 1
        expect_result_data_to_match_expected(results, [[@fauzi, @franky]])
      end

      it 'returns path for topic endorsed indirectly through direct contact' do
        #------------------------------------------------------------------------------
        # nuno -- KNOWS --> tisha --> ENDORSES('Composer') --> Person
        #  ( A--> KNOWS -->B KNOWS & ENDORSES --> C)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @nuno, 'Composer', 1
        expect_result_data_to_match_expected(results, [[@nuno, @tisha, @vince]])
      end

      it "doesn't find path if min distance it too short" do
        #------------------------------------------------------------------------------
        # fauzi --> KNOWS --> franky --> KNOWS--> (nuno) --> KNOWS --> (tisha)  ENDORSES --> (vince:NOT_RETURNED)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @fauzi, 'Composer', 2
        expect_result_data_to_match_expected(results, empty_set)
      end

      it 'finds path to contacts within default distance = 3' do
        #------------------------------------------------------------------------------
        # fauzi --> KNOWS --> franky --> KNOWS--> (nuno) --> KNOWS --> (tisha)  ENDORSES --> (vince)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @fauzi, 'Composer'
        expect_result_data_to_match_expected(results, [[@fauzi, @franky, @nuno, @tisha, @vince]])
      end

      pending 'finds path to contacts within default distance = 3 and obfuscates non direct contacts' do
        #------------------------------------------------------------------------------
        # fauzi --> KNOWS --> franky --> KNOWS--> (nuno) --> KNOWS --> (tisha)  ENDORSES --> (vince)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @fauzi, 'Composer'
        expect_result_data_to_match_expected(results, [[@fauzi, @franky, @hidden, @hidden]])
      end

      it 'finds path to contacts that have endorsed the topic by depth' do
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @jean, 'Acting', 5
        expect_result_data_to_match_expected(results, [[@jean, @vince, @tisha, @nuno, @stan, @elsa, @sar]])
      end
    end

    context 'multiple paths to endorsee' do
      it 'finds multiple path to contacts that have endorsed the topic by specified depth' do
        # ------------------------------------------------------------------------------
        # PATH 1
        # ["Elsa ", "Stan ", "Nuno ", "Wid", "Rico"]
        #------------------------------------------------------------------------------

        #------------------------------------------------------------------------------
        #  PATH 2
        # ["Elsa ", "Stan ", "Nuno ", "Franky "]
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @elsa, 'Beatmaking', 4
        expect_result_data_to_match_expected(results,
                                             [[@elsa, @stan, @nuno, @wid, @rico], [@elsa, @stan, @nuno, @franky]])
      end

      it "doesn't include routes exceeding max distance" do
        # ------------------------------------------------------------------------------
        # PATH 1
        # ["Vince ", "Tish ", "Nuno ", "Wid"]
        #------------------------------------------------------------------------------

        #------------------------------------------------------------------------------
        #  PATH 2 -- NOT INCLUDED
        # ["Vinc ", "Tish ", "Nuno ", "Stan", "Elsa", "Herby"]
        #------------------------------------------------------------------------------

        results = EndorsementSearchService.paths_to_resource @vince, 'Software', 3
        expect_result_data_to_match_expected(results, [
                                               [@vince, @tisha, @nuno, @wid]
                                             ])
      end

      it 'does a mixed thing' do
        results = EndorsementSearchService.paths_to_resource @fauzi, 'Beatmaking'
        expect_result_data_to_match_expected(results, [[@fauzi, @franky, @nuno], [@fauzi, @franky, @nuno, @wid, @rico]])
      end
  
      it "doesn't show circular references routes when endorser endorsed directly and reachable through friend path" do
        #------------------------------------------------------------------------------
        # herby -KNOWS-> elsa -KNOWS->stan
        #------------------------------------------------------------------------------
  
        # NOT returned since herby doesn't need to through sar to get to elsa.
        #------------------------------------------------------------------------------
        # herby -KNOWS-> sar -KNOWS-> elsa -KNOWS->stan
        #------------------------------------------------------------------------------
  
        results = EndorsementSearchService.paths_to_resource @herby, 'Basketball'
        expect_result_data_to_match_expected(results, [[@herby, @elsa, @stan]])
      end

    end
  end

end


def expect_result_data_to_match_expected(result_names, expected)
  expected_names = expected.map { |path| path.map(&:name) }
  expect(result_names.to_set).to match_array expected_names.to_set
end
