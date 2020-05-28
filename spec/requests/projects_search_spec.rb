require "rails_helper"
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils

describe Api::V1::ProjectsController do
  before do
    setup_relationship_data
    setup_projects
  end

  after do
    clear_db
  end

 describe "post api/v1/projects/:topic" do 
   it "finds friends that have direct connection to this topic" do

     post "/api/v1/projects/search", params:{topic: @cooking.id}, headers:{'Authorization': Authentication.jwt_for(@herby.identity)}

     expect(response.status).to eq 200

     expected_project_names =  [ "Culinary"].to_set
     results = extract_project_names(JSON.parse(response.body))

     expect(expected_project_names).to eq(results.to_set)

   end


   def extract_project_names results
     results["projects"]["data"].map{|d|d["attributes"]["name"]}
   end
 end


end
