require "rails_helper"
include RelationshipHelper

describe Api::V1::TopicContactsController do
  before do 
    setup_relationship_data
  end

 describe "get api/v1/topic_contacts/:topic" do 
   it "finds friends that have direct connection to this topic" do

     get "/api/v1/topic_contacts/Cooking", headers:{'Authorization': Authentication.jwt_for(@herby)}

     json = JSON.parse(response.body)
     expect(response.status).to eq 200
     expect(json.size).to eq 2
   end

   #it "finds friends that have indirect connection to this topic" do

     #get "/api/v1/topic_contacts/Singing", headers:{'Authorization': Authentication.jwt_for(@sar)}

     #json = JSON.parse(response.body)
     #binding.pry
     #expect(response.status).to eq 200
     #expect(json.size).to eq 2
   #end

 end

end
