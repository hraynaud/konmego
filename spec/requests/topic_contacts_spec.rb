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

     get "/api/v1/topic_contacts/Cooking", headers:{'Authorization': Authentication.jwt_for(@sar)}

     data = JSON.parse(response.body)

     expect(response.status).to eq 200
     expect(data["nodes"].size).to eq sars_cooking_network["nodes"].size
     expect(data["links"].size).to eq sars_cooking_network["links"].size
     validate_relationship_types data, sars_cooking_network
     validate_node_types data, sars_cooking_network
   end

 end


 def validate_node_types data, expected
   ["Person","Endorsement","Topic"].each do |type| 
     expect( node_type_count(data, type)).to eq node_type_count(expected, type)
   end
 end

 def validate_relationship_types data, expected
   ["KNOWS","ENDORSEMENT_SOURCE","ENDORSE_TOPIC"].each do |type| 
     expect( link_type_count(data, type)).to eq link_type_count(expected, type)
   end
 end

 def link_type_count link_data, type
   link_data["links"].select{|l|l["type"] == type}.size
 end

 def node_type_count node_data, type
   node_data["nodes"].select{|l|l["type"] == type}.size
 end
end
