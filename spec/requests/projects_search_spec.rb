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

     post "/api/v1/projects/search", params:{topic: "Cooking"}, headers:{'Authorization': Authentication.jwt_for(@herby)}

     expect(response.status).to eq 200
     expected_project_names =  [ "Culinary", "Fine Dining", "Find chef 1" ]
     projects = JSON.parse(response.body)

     expect(projects.map{|x|x["name"]}.difference expected_project_names ).to eq([])

   end

 end


end
