require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Utils
include TestDataHelper::SampleResults

describe Person do

  before do
    clear_db
    setup_relationship_data
  end

  # TODO: might be redundant with test in RelationshipManager
  describe '.contacts' do
    it 'finds all friends of given user' do
      RelationshipManager.befriend @tisha, @vince
      RelationshipManager.befriend @tisha, @nuno
      expect(extract_names(@tisha.contacts)).to eq extract_names([@nuno, @vince])
    end
  end

  describe '.endorsees' do
    it 'finds all endorsees of given user' do
      expect(extract_names(@tisha.endorsees)).to eq extract_names([@nuno, @vince])
    end
  end
end
