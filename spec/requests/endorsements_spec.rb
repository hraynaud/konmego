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

  describe "creating endorsement: post api/v1/endorsements" do 

    context "for pre-existing topic and endorsee" do
      it " creates endorsment for existing user and existing topic" do
        do_post @herby, "/api/v1/endorsements", {topicId: @cooking.id , endorseeId: @tisha.id}
        expect_http response, :ok
      end

      it " fails when edorsee is missing" do
        do_post @herby, "/api/v1/endorsements", {topicId: @cooking.id }
        aggregate_failures do 
          expect_http response, :unprocessable_entity
        end
      end

      it " fails when topic is missing" do
        do_post @herby, "/api/v1/endorsements", {endorseeId: @tisha.id}
        aggregate_failures do 
          expect_http response, :unprocessable_entity
        end
      end
    end

    context "when either topic or endorsee or both are new" do
      let(:new_topic){ {newTopic: {name: "My New Topic"}} }
      let(:new_person){ {newPerson: {first: "Firstly", last: "Lastly", identity: {email: "first@last.com"}} }}

      context "new topic" do
        let(:params){new_topic.merge({endorseeId: @tisha.id})}

        it "returns ok" do
          do_post @herby, "/api/v1/endorsements", params
          expect_http response, :ok
          expect_response_and_model_json_to_match response, Endorsement.last
        end

        it "creates new endorsement and new topic" do
          expect{
            do_post @herby, "/api/v1/endorsements", params
          }.to change{Endorsement.count}.by(1)
            .and change{Topic.count}.by(1)
            .and change{Person.count}.by(0)
        end
      end

      context "new person creates invite" do
        let(:params){new_person.merge({topicId: @singing.id})}

        it "creates an invite if new person" do
          do_post @herby, "/api/v1/endorsements", params 
          expect_http response, :ok
          expect_response_and_model_json_to_match response, Invite.last
        end

        it "creates invite but not endorsement" do
          expect{
            do_post @herby, "/api/v1/endorsements", params
          }.to change{Endorsement.count}.by(0)
            .and change{Invite.count}.by(1)
        end
      end

      context "new persn an topic creates new invite and topic" do
        let(:new_person_and_topic){ new_topic.merge(new_person) }

        it "creates new endorsement and new person" do
          do_post @herby, "/api/v1/endorsements", new_person_and_topic
          expect_http response, :ok
          expect_response_and_model_json_to_match response, Invite.last
        end

        it "creates new invite and topic" do
          expect{
            do_post @herby, "/api/v1/endorsements", new_person_and_topic
          }.to change{Endorsement.count}.by(0)
            .and change{Invite.count}.by(1)
            .and change{Topic.count}.by(1)
        end
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
