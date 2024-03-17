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
    context 'by topic' do # rubocop:disable Metrics/BlockLength
      context 'Single paths results' do # rubocop:disable Metrics/BlockLength
        it 'returns path for topic directly endorsed by person ' do
          #------------------------------------------------------------------------------
          # fauzi -- ENDORSES('Cooking') --> franky ( A--> KNOWS & ENDORSES -->B )
          #------------------------------------------------------------------------------
          mock_like_terms('Cooking')
          results = EndorsementSearchService.search @fauzi, { topic: 'Cooking', hops: 1, tolerance: 0.99 }
          expect_actual_to_match_expected results, 'Cooking', [[@fauzi]], @fauzi, @franky

        end

        it 'returns path for topic endorsed indirectly through direct contact' do
          #------------------------------------------------------------------------------
          # nuno -- KNOWS --> tisha --> ENDORSES('Composer') --> Person
          #  ( A--> KNOWS -->B KNOWS & ENDORSES --> C)
          #------------------------------------------------------------------------------
          mock_like_terms('Composer')
          results = EndorsementSearchService.search @nuno, { topic: 'Composer', hops: 1 }
          expect_actual_to_match_expected results, 'Composer', [[@nuno, @tisha]], @tisha, @vince
        end

        it 'finds path to contacts within default distance = 3' do
          #------------------------------------------------------------------------------
          # fauzi --> KNOWS --> franky --> KNOWS--> (nuno) --> KNOWS --> (tisha)  ENDORSES --> (vince)
          #------------------------------------------------------------------------------
          mock_like_terms('Composer')
          results = EndorsementSearchService.search @fauzi, { topic: 'Composer' }
          expect_actual_to_match_expected results, 'Composer', [[@fauzi, @franky, @nuno, @tisha]], @tisha, @vince
        end

        it 'finds path the topic as long as endorsee is within specified num hops' do

          #------------------------------------------------------------------------------
          # ["Gilber", "Elsa ", "Stan ", "Nuno ", "Franky","Fauzi"]
          #------------------------------------------------------------------------------
          mock_like_terms('Cooking')
          results = EndorsementSearchService.search @gilbert, { topic: 'Cooking', hops: 5 }
          expect_actual_to_match_expected results, 'Cooking', [[@gilbert, @elsa, @stan, @nuno, @franky, @fauzi]], @fauzi,
                                          @franky
        end

        it "doesn't find path if specified it too short" do
          #------------------------------------------------------------------------------
          # fauzi --> KNOWS --> franky --> KNOWS--> (nuno) --> KNOWS --> (tisha)  ENDORSES --> (vince:NOT_RETURNED)
          #------------------------------------------------------------------------------
          mock_like_terms('Composer')
          results = EndorsementSearchService.search @fauzi, { topic: 'Composer', hops: 2 }
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
            mock_like_terms('Beat making')
            results = EndorsementSearchService.search(@elsa, { topic: 'Beat Making', hops: 4 })
            expect_actual_to_match_expected(results, 'Beat Making',
                                            [[@elsa, @stan, @nuno], [@elsa, @stan, @nuno, @wid, @rico]], @nuno, @franky, 0)
            expect_actual_to_match_expected(results, 'Beat Making',
                                            [[@elsa, @stan, @nuno], [@elsa, @stan, @nuno, @wid, @rico]], @rico, @wid, 1)
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
          mock_like_terms('Software')
          results = EndorsementSearchService.search @vince, { topic: 'Software', hops: (3 + 1) }
          expect_actual_to_match_expected results, 'Software',
                                          [[@vince, @tisha, @nuno], [@vince, @tisha, @nuno, @stan, @elsa]], @nuno, @wid, 1
          expect_actual_to_match_expected results, 'Software',
                                          [[@vince, @tisha, @nuno], [@vince, @tisha, @nuno, @stan, @elsa]], @elsa, @herby, 0

          #------------------------------------------------------------------------------
          #  PATH 2 -- NOT INCLUDED
          # ["Vince ", "Tisha", "Nuno ", "Stan", "Elsa", "Herby"]
          #------------------------------------------------------------------------------
          mock_like_terms('Software')
          results = EndorsementSearchService.search @vince, { topic: 'Software', hops: 3 }
          expect_actual_to_match_expected results, 'Software', [[@vince, @tisha, @nuno]], @nuno, @wid, 0
        end

        it 'retuns the shortest path' do
          #------------------------------------------------------------------------------
          # herby -KNOWS-> elsa -KNOWS->stan
          #------------------------------------------------------------------------------

          # NOT returned since herby doesn't need to through sar to get to elsa.
          #------------------------------------------------------------------------------
          # herby -KNOWS-> sar -KNOWS-> elsa -KNOWS->stan
          #------------------------------------------------------------------------------
          mock_like_terms('Basketball')
          results = EndorsementSearchService.search @herby, { topic: 'Basketball' }

          expect(@herby.friends_with?(@sar)).to be true
          expect(@elsa.friends_with?(@sar)).to be true
          expect(results.count).to eq 1
          expect_actual_to_match_expected results, 'Basketball', [[@herby, @elsa]], @elsa, @stan

        end

      end
    end

    context 'Similarity Search' do
      it 'returns path for similarity search' do
        #------------------------------------------------------------------------------
        # stan -- KNOWS -- elsa --> ENDORSES('Acting') --> sar <-- gilber endorse("Thespian")
        #  ( A--> KNOWS -->B KNOWS & ENDORSES --> C)
        #------------------------------------------------------------------------------
        #
        create_endorsement(@gilbert, @sar, @acting,
                           'Sar is a true thespian. He truly embodies ever role that he takes on when it hit the stage')
        results = EndorsementSearchService.search @stan,
                                                  { query: to_embed_txt('Who do i know that Acted in broadway play or hollywood movie'), hops: 1,
                                                    tolerance: 0.64 }
        expect_actual_to_match_expected results, 'Acting', [[@stan, @elsa]], @elsa, @sar, 0
      end

      it 'finds path to contacts that have endorsed the topic within specified hops' do
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.search @jean,
                                                  { query: to_embed_txt('Acting on stage'), hops: 5, tolerance: 0.64 }
        expect_actual_to_match_expected results, 'Acting', [[@jean, @vince, @tisha, @nuno, @stan, @elsa]], @elsa,
                                        @sar
      end
    end
  end

end

def expect_actual_to_match_expected(results, topic, paths, from, to, index = 0) # rubocop:disable Metrics/ParameterLists
  endorsement = results.pluck(:e)[index]
  expect(endorsement.endorser).to eq(from)
  expect(endorsement.endorsee).to eq(to)
  expect(endorsement.topic.name).to eq(topic)
  expect_actual_paths_to_contain_expected(results, paths)
end

def expect_actual_paths_to_contain_expected(results, expected_paths)
  actual_paths = results.pluck(:all_paths)
  expect(results.count).to eq expected_paths.count
  expect(actual_paths.sort).to eq(expected_paths.sort)
end
