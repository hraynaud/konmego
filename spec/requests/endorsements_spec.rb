require "rails_helper"
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils

describe Api::V1::EndorsementsController do

  let(:new_topic){ {new_topic: {name: "My New Topic"}} }

  before do
    setup_relationship_data
  end

  after do
    clear_db
  end

  describe "post api/v1/endorsements" do 
    it " creates endorsment for existing user and existing topic" do

      post "/api/v1/endorsements", params:{topicId: @cooking.id , endorseeId: @tisha.id}, headers:{'Authorization': Authentication.jwt_for(@herby)}

      aggregate_failures do 
        expect(response.status).to eq 200
      end

    end


    it " fails when edorsee is missing" do
      post "/api/v1/endorsements", params:{topicId: @cooking.id}, headers:{'Authorization': Authentication.jwt_for(@herby)}

      aggregate_failures do 
        expect(response.status).to eq 200
      end

    end

  end
end
