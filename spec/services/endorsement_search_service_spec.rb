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
        topic, names, _visibility = extract_test_data results
        expect(topic).to eq("Cooking")
        expect_result_data_to_match_expected(names, get_names([[@fauzi, @franky]]))
      end

      it 'returns path for topic endorsed indirectly through direct contact' do
        #------------------------------------------------------------------------------
        # nuno -- KNOWS --> tisha --> ENDORSES('Composer') --> Person
        #  ( A--> KNOWS -->B KNOWS & ENDORSES --> C)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @nuno, 'Composer', 1
        topic, names, _visibility = extract_test_data results
        expect(topic).to eq("Composer")
        expect_result_data_to_match_expected(names, get_names([[@nuno, @tisha, @vince]]))
      end

      it "doesn't find path if min distance it too short" do
        #------------------------------------------------------------------------------
        # fauzi --> KNOWS --> franky --> KNOWS--> (nuno) --> KNOWS --> (tisha)  ENDORSES --> (vince:NOT_RETURNED)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @fauzi, 'Composer', 2
        topic, names, _visibility = extract_test_data results
        expect(topic).to eq("")
        expect_result_data_to_match_expected(names, empty_set)
      end

      it 'finds path to contacts within default distance = 3' do
        #------------------------------------------------------------------------------
        # fauzi --> KNOWS --> franky --> KNOWS--> (nuno) --> KNOWS --> (tisha)  ENDORSES --> (vince)
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @fauzi, 'Composer'
        topic, names, _visibility = extract_test_data results
        expect(topic).to eq("Composer")
        expect_result_data_to_match_expected(names, get_names([[@fauzi, @franky, @nuno, @tisha, @vince]]))
      end

      it 'finds path to contacts that have endorsed the topic by depth' do
        #------------------------------------------------------------------------------
        results = EndorsementSearchService.paths_to_resource @jean, 'Acting', 5
        topic, names, _visibility = extract_test_data results
        expect(topic).to eq("Acting")
        expect_result_data_to_match_expected(names, get_names([[@jean, @vince, @tisha, @nuno, @stan, @elsa, @sar]]))
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
        topic, names, _visibility = extract_test_data results
        expect(topic).to eq("Beatmaking")
        expect_result_data_to_match_expected(names,
          get_names([[@elsa, @stan, @nuno, @wid, @rico], [@elsa, @stan, @nuno, @franky]]))
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
        topic, names, _visibility = extract_test_data results
        expect(topic).to eq("Software")
        expect_result_data_to_match_expected(names, get_names([
                                               [@vince, @tisha, @nuno, @wid]
                                             ]))
      end

      it 'finds mixeds paths and marks remote non-friends nodes as invisible' do
        results = EndorsementSearchService.paths_to_resource @fauzi, 'Beatmaking'
        
        topic, names, visibility = extract_test_data results
        expect(topic).to eq("Beatmaking")
        expect_result_data_to_match_expected(names, get_names([[@fauzi, @franky, @nuno], [@fauzi, @franky, @nuno, @wid, @rico]]))
        expect_result_data_to_match_expected(visibility, [[ true, true, false], [true, true, false, false, false]])
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
         
        topic, names, _visibility = extract_test_data results
        expect(topic).to eq("Basketball")
        expect_result_data_to_match_expected(names, get_names([[@herby, @elsa, @stan]]))
      end

    end
  end

end


def extract_test_data results 
  topic, data = extract_node_data results
  names = data.map{|p|p.pluck(:name)}
  visibility = data.map{|p|p.pluck(:is_visible)}
  return topic, names, visibility
end

def extract_node_data data
  topic = ""
  paths = data.map do |path_data|
    topic = path_data[:topic]
    path_data[:path].map{|n|n.slice(:name, :is_visible)}
  end
  return topic, paths
end

def expect_result_data_to_match_expected(results, expected)
  expect(results.to_set).to match_array expected.to_set
end

def get_names expected
  expected.map { |path| 
    path.map(&:name) 
  }
end