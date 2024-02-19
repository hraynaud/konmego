require 'set'
require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Utils

describe EndorsementSearchService do # rubocop:disable Metrics/BlockLength
  before(:all) do
    clear_db
    setup_relationship_data
  end

  after(:all) do
    clear_db
  end

  describe '.search' do # rubocop:disable Metrics/BlockLength
    context 'Single paths results' do # rubocop:disable Metrics/BlockLength
      it 'returns path for topic directly endorsed by person ' do
        #------------------------------------------------------------------------------
        # fauzi -- ENDORSES('Cooking') --> franky ( A--> KNOWS & ENDORSES -->B )
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.search @fauzi, 'Cooking', 1
        expect_actual_to_match_expected results, 'Cooking', [@fauzi, @franky], @fauzi, @franky

      end

      it 'returns path for topic endorsed indirectly through direct contact' do
        #------------------------------------------------------------------------------
        # nuno -- KNOWS --> tisha --> ENDORSES('Composer') --> Person
        #  ( A--> KNOWS -->B KNOWS & ENDORSES --> C)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.search @nuno, 'Composer', 1
        expect_actual_to_match_expected results, 'Composer', [@nuno, @tisha, @vince], @tisha, @vince
      end

      it 'finds path to contacts within default distance = 3' do
        #------------------------------------------------------------------------------
        # fauzi --> KNOWS --> franky --> KNOWS--> (nuno) --> KNOWS --> (tisha)  ENDORSES --> (vince)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.search @fauzi, 'Composer'
        expect_actual_to_match_expected results, 'Composer', [@fauzi, @franky, @nuno, @tisha, @vince], @tisha, @vince
      end

      it 'finds path to contacts that have endorsed the topic within specified hops' do
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.search @jean, 'Acting', 5
        expect_actual_to_match_expected results, 'Acting', [@jean, @vince, @tisha, @nuno, @stan, @elsa, @sar], @elsa,
                                        @sar
      end

      it 'finds path the topic as long as endorsee is within specified num hops' do

        #------------------------------------------------------------------------------
        # ["Gilber", "Elsa ", "Stan ", "Nuno ", "Franky","Fauzi"]
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.search @gilbert, 'Cooking', 5
        expect_actual_to_match_expected results, 'Cooking', [@gilbert, @elsa, @stan, @nuno, @franky, @fauzi], @fauzi,
                                        @franky
      end

      it "doesn't find path if specified it too short" do
        #------------------------------------------------------------------------------
        # fauzi --> KNOWS --> franky --> KNOWS--> (nuno) --> KNOWS --> (tisha)  ENDORSES --> (vince:NOT_RETURNED)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.search @fauzi, 'Composer', 2
        expect(results.to_set).to eq(empty_set)
      end

    end

    context 'multiple paths to endorsee' do

      context 'finds multiple paths to contacts that have endorsed the topic by specified depth' do

        # ------------------------------------------------------------------------------
        # PATH 1
        # ["Elsa ", "Stan ", "Nuno ", "Wid", "Rico"]
        #------------------------------------------------------------------------------

        #------------------------------------------------------------------------------
        #  PATH 2
        # ["Elsa ", "Stan ", "Nuno ", "Franky "]
        #------------------------------------------------------------------------------

        it 'finds first path' do
          results = EndorsementSearchService.search @elsa, 'Beatmaking', 3
          expect_actual_to_match_expected results, 'Beatmaking', [@elsa, @stan, @nuno, @franky], @nuno, @franky, 0
          expect_actual_to_match_expected results, 'Beatmaking', [@elsa, @stan, @wid, @rico], @rico, @wid, 1

        end

      end

      it "doesn't include paths exceeding max distance" do
        # ------------------------------------------------------------------------------
        # PATH 1
        # ["Vince ", "Tish ", "Nuno ", "Wid"]
        #------------------------------------------------------------------------------

        #------------------------------------------------------------------------------
        #  PATH 2 --INCLUDED
        # ["Vine ", "Tisha", "Nuno ", "Stan", "Elsa", "Herby"]
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.search @vince, 'Software', 4
        expect_actual_to_match_expected results, 'Software', [@vince, @tisha, @nuno, @wid], @nuno, @wid, 0
        expect_actual_to_match_expected results, 'Software', [@vince, @tisha, @nuno, @stan, @elsa, @herby], @elsa,
                                        @herby, 1

        #------------------------------------------------------------------------------
        #  PATH 2 -- NOT INCLUDED
        # ["Vine ", "Tisha", "Nuno ", "Stan", "Elsa", "Herby"]
        #------------------------------------------------------------------------------

        results = EndorsementSearchService.search @vince, 'Software', 3
        expect_actual_to_match_expected results, 'Software', [@vince, @tisha, @nuno, @wid], @nuno, @wid, 0
      end

      it 'retuns the shortest path' do
        #------------------------------------------------------------------------------
        # herby -KNOWS-> elsa -KNOWS->stan
        #------------------------------------------------------------------------------

        # NOT returned since herby doesn't need to through sar to get to elsa.
        #------------------------------------------------------------------------------
        # herby -KNOWS-> sar -KNOWS-> elsa -KNOWS->stan
        #------------------------------------------------------------------------------

        results = EndorsementSearchService.search @herby, 'Basketball'

        expect(results.count).to eq 1

        expect(@herby.friends_with?(@sar)).to be true
        expect(@elsa.friends_with?(@sar)).to be true

        expect_actual_to_match_expected results, 'Basketball', [@herby, @elsa, @stan], @elsa, @stan

      end

    end
  end

end

def expect_actual_to_match_expected(results, expected_topic, expected_paths, expected_from, expected_to, index = 0) # rubocop:disable Metrics/AbcSize,Metrics/ParameterLists
  endorsement = results.pluck(:e)[index]

  actual_paths = results.pluck(:all_paths)[index]
  expect(actual_paths).to eq(expected_paths)
  expect(endorsement.from_node).to eq(expected_from)
  expect(endorsement.to_node).to eq(expected_to)
  expect(endorsement.topic).to eq(expected_topic)
end
