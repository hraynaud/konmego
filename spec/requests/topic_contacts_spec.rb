require "rails_helper"
include TestDataHelper::Relationships
include TestDataHelper::Utils

describe Api::V1::TopicContactsController do
  before do 
    setup_relationship_data
  end

  after do 
    clear_db
  end

 describe "get api/v1/topic_contacts/:topic" do 
   it "finds friends that have direct connection to this topic" do

     connection_paths =  [
       ["Herby, Skillz", "Tisha, Skillz"],
       ["Herby, Skillz", "Fauzi, Skillz", "Tisha, Skillz"],
       ["Herby, Skillz", "Jean, Skillz", "Vince, Skillz", "Tisha, Skillz"],
       ["Herby, Skillz", "Fauzi, Skillz"],
       ["Herby, Skillz", "Tisha, Skillz", "Fauzi, Skillz"]
     ]

     get "/api/v1/topic_contacts/Cooking", headers:{'Authorization': Authentication.jwt_for(@herby)}

     connections = JSON.parse(response.body)
     expect(response.status).to eq 200
     expect(connections.difference connection_paths ).to eq([])

   end

 end

end
