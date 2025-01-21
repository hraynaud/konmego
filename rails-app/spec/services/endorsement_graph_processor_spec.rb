require 'set'
require 'ostruct'
require 'rails_helper'

include TestDataHelper::Relationships
include TestDataHelper::Utils

describe EndorsementGraphProcessor do # rubocop:disable Metrics/BlockLength
  before(:all) do
    @anon = OpenStruct.new(first_name: 'Anonymous')
    clear_db

    setup_relationship_data
  end

  after(:all) do
    clear_db
  end

  describe '.search' do # rubocop:disable Metrics/BlockLength
    context 'root node is endorser or endorser is in friend chain between the root node and endorsee' do
      it "doesn't anonymize if current user is endorser and knows endorsee directly " do
        #------------------------------------------------------------------------------
        # fauzi -- ENDORSES('Cooking') --> franky ( A--> KNOWS & ENDORSES -->B )
        #------------------------------------------------------------------------------
        mock_like_terms(@cooking.name)

        graph = EndorsementSearchService.search @fauzi, topic_name: 'Cooking', hops: 1,
                                                        vector: false
        results = EndorsementGraphProcessor.process @fauzi, graph
        actual = extract_assertable_data(results)

        expected = [
          {
            topic: 'Cooking',
            path: to_path_nodes([[@fauzi, 'endorser', true]])
          }
        ]
        expect(actual).to eq(expected)
      end

      it 'anonymizes nodes beyond direct friendship relationships with root node' do
        #------------------------------------------------------------------------------
        # nuno -- KNOWS --> tisha --> ENDORSES('Composer') --> Person
        #  ( A--> KNOWS -->B KNOWS & ENDORSES --> C)
        #------------------------------------------------------------------------------
        mock_like_terms(@composer.name)
        graph = EndorsementSearchService.search @nuno, topic_name: 'Composer', hops: 1,
                                                       vector: false
        results = EndorsementGraphProcessor.process @nuno, graph
        actual = extract_assertable_data(results)
        expected = [
          {
            topic: 'Composer',
            path: to_path_nodes([[@nuno, 'me', true], [@tisha, 'endorser', true]])
          }
        ]
        expect(actual).to eq(expected)

      end
    end

    it 'processes multiple paths correctly' do
      mock_like_terms(@beatmaking.name)
      graph = EndorsementSearchService.search @fauzi,
                                              topic_name: 'Beat Making', hops: 4, vector: false
      results = EndorsementGraphProcessor.process @fauzi, graph
      actual = extract_assertable_data(results)

      expected = [
        {
          topic: 'Beat Making',
          path: to_path_nodes([[@fauzi, 'me', true], [@franky, 'endorsee', true], [@anon, 'endorser', false]])
        },
        {
          topic: 'Beat Making',
          path: to_path_nodes(
            [
              [@fauzi, 'me', true], [@franky, 'contact', true], [@anon, 'contact', false],
              [@anon, 'endorsee', false], [@anon, 'endorser', false]
            ]
          )
        }
      ]
      expect(actual).to eq(expected)
    end
  end
end

def extract_assertable_data(results)
  results.map do |result|
    {
      topic: result.topic.name,
      path: result.path.map { |p| p.slice(:name, :role, :is_visible) }
    }
  end
end

def to_path_nodes(node_configs)
  node_configs.map do |config|
    to_endorsement_node(*config)
  end
end

def to_endorsement_node(person, role, is_visible)
  {
    name: person.first_name,
    role:,
    is_visible:
  }
end
