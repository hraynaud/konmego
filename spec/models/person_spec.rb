require "rails_helper"
include TestDataHelper::Relationships
include TestDataHelper::Utils
include TestDataHelper::SampleResults

describe Person do

  before do
    clear_db
    setup_relationship_data
  end

  describe ".contacts" do 
    it "finds all friends of given user" do
      expect(extract_names(@tisha.contacts)).to eq extract_names([@kendra,@herby,@vince])
    end
  end

  describe ".endorsees" do 
    it "finds all endorsees of given user" do
      expect(extract_names(@tisha.endorsees)).to eq extract_names([@kendra, @vince])
    end
  end
end
