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
      expect(@tisha.contacts.to_set).to eq [@kendra,@herby,@vince].to_set
    end
  end

  describe ".endorsees" do 
    it "finds all friends of given user" do
      expect(@tisha.endorsees.to_set).to eq [@kendra].to_set
    end
  end
end
