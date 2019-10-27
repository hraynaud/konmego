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
        expect(response.status).to eq 200
      end

    end


    it " fails when edorsee is missing" do
      post "/api/v1/endorsements", params:{topicId: @cooking.id}, headers:{'Authorization': Authentication.jwt_for(@herby)}

      aggregate_failures do 
        expect(response).to have_http_status(:unprocessable_entity)
        #TODO validate response body
      end

    end

    it " fails when topic is missing" do
      post "/api/v1/endorsements", params:{endorseeId: @tisha.id}, headers:{'Authorization': Authentication.jwt_for(@herby)}

      aggregate_failures do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end

  end

  describe "accept" do
    it "upates the status of the endorsement" do
      t = FactoryBot.create(:topic, name: "Skeptic")
      e = FactoryBot.create(:endorsement, endorser: @tisha, endorsee: @herby, topic: t)
      expect{
        do_put @herby, "/api/v1/endorsements/#{e.id}/accept"
        e.reload
      }.to change{ e.status }.to :accepted
    end

    it "fails if endorsement doesn't exist" do
      do_put @herby, "/api/v1/endorsements/ABC123/accept"
        expect(response).to have_http_status(:not_found)
    end
  end

  describe "decline" do
    it "upates the status of the endorsement" do
      t = FactoryBot.create(:topic, name: "Skeptic")
      e = FactoryBot.create(:endorsement, endorser: @tisha, endorsee: @herby, topic: t)
      expect{
        do_put @herby, "/api/v1/endorsements/#{e.id}/decline"
        e.reload
      }.to change{ e.status }.to :declined
    end

    it "fails if endorsement doesn't exist" do
      do_put @herby, "/api/v1/endorsements/ABC123/decline"
      expect(response).to have_http_status(:not_found)
    end

  end

end
