require "rails_helper"
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils

describe Api::V1::EndorsementsController, :type => :request do

  before do
    create_social_graph
  end

  after do
    clear_db
  end

  describe "post api/v1/endorsements" do 
    let(:new_topic){ {new_topic: {name: "My New Topic"}} }

    it " creates endorsment for existing user and existing topic" do

      post "/api/v1/endorsements", params:{topicId: @cooking.id , endorseeId: @tisha.id}, headers:{'Authorization': Authentication.jwt_for(@herby)}

      aggregate_failures do 
        expect_http response, :ok
      end

    end


    it " fails when edorsee is missing" do
      post "/api/v1/endorsements", params:{topicId: @cooking.id}, headers:{'Authorization': Authentication.jwt_for(@herby)}

      aggregate_failures do 
        expect_http response, :unprocessable_entity
        #TODO validate response body
      end

    end

    it " fails when topic is missing" do
      post "/api/v1/endorsements", params:{endorseeId: @tisha.id}, headers:{'Authorization': Authentication.jwt_for(@herby)}

      aggregate_failures do 
        expect_http response, :unprocessable_entity
      end

    end

  end

  context "Accept and Decline" do

    let(:t){FactoryBot.create(:topic, name: "Skeptic")}
    let(:e){FactoryBot.create(:endorsement, endorser: @tisha, endorsee: @herby, topic: t)}
    let(:bad_id){"ABC123"}

    describe "accept" do

      it "upates the status of the endorsement" do
        expect{
          do_put @herby, accept_api_v1_endorsement_path(e)
          e.reload
        }.to change{ e.status }.to :accepted
      end

      it "returns updated endorsement" do
        do_put @herby, accept_api_v1_endorsement_path(e)
        expect_response_and_model_json_to_match response, e.reload 
      end

      it "fails if endorsement doesn't exist" do
        do_put @herby, "/api/v1/endorsements/#{bad_id}/accept"
        expect_http response, :not_found
      end

    end

    describe "decline" do
      it "upates the status of the endorsement" do
        expect{
          do_put @herby,  decline_api_v1_endorsement_path(e)
          e.reload
        }.to change{ e.status }.to :declined
      end

      it "returns updated endorsement" do
        do_put @herby, decline_api_v1_endorsement_path(e)
        expect_response_and_model_json_to_match response, e.reload 
      end

      it "fails if endorsement doesn't exist" do
        do_put @herby, "/api/v1/endorsements/#{bad_id}/decline"
        expect_http response, :not_found
      end

    end
  end
end
