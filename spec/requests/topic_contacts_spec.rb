require "rails_helper"
include TestDataHelper::Relationships
include TestDataHelper::Utils
include TestDataHelper::SampleResults

describe Api::V1::TopicContactsController do
  before do 
    clear_db
    setup_relationship_data
  end


 describe "get api/v1/topic_contacts/:topic" do 
   it "finds friends that have direct connection to this topic" do

     do_get @fauzi, "/api/v1/topic_contacts/Singing" 
     expect_http response,:ok
   end

 end
end
