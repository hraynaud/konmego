require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils

describe Api::V1::EndorsementsController, type: :request do # rubocop:disable Metrics/BlockLength

  before do
    create_social_graph
  end

  after do
    clear_db
  end

  describe 'creating endorsement: post api/v1/endorsements' do # rubocop:disable Metrics/BlockLength

    context 'for pre-existing topic and endorsee' do
      it ' creates endorsment for existing user and existing topic' do
        do_post @herby, '/api/v1/endorsements', { topicId: @cooking.id, endorseeId: @tisha.id }
        expect_http response, :ok
      end

      it ' fails when edorsee is missing' do
        do_post @herby, '/api/v1/endorsements', { topicId: @cooking.id }
        aggregate_failures do
          expect_http response, :unprocessable_entity
        end
      end

      it ' fails when topic is missing' do
        do_post @herby, '/api/v1/endorsements', { endorseeId: @tisha.id }
        aggregate_failures do
          expect_http response, :unprocessable_entity
        end
      end
    end

    context 'when either topic or endorsee or both are new' do # rubocop:disable Metrics/BlockLength
      let(:new_topic) { { newTopic: { name: 'My New Topic' } } }
      let(:new_person) { { newPerson: { first: 'Firstly', last: 'Lastly', identity: { email: 'first@last.com' } } } }

      context 'new topic only' do
        let(:params) { new_topic.merge({ endorseeId: @tisha.id }) }

        it 'returns ok' do
          do_post @herby, '/api/v1/endorsements', params
          expect_http response, :ok
        end

        it 'creates new endorsement and a new topic' do
          expect do
            do_post @herby, '/api/v1/endorsements', params
          end.to change { @herby.endorsees.count }.by(1)
                                                  .and change { Topic.count }.by(1)
                                                                             .and change { Person.count }.by(0)
        end
      end

      context 'new person only' do
        let(:params) { new_person.merge({ topicId: @singing.id }) }

        it 'succeeds and returns created endorsement as response' do
          do_post @herby, '/api/v1/endorsements', params
          expect_http response, :ok
          expect_response_and_model_json_to_match response, Endorse.last
        end

      end

      context 'new person and new topic' do
        let(:new_person_and_topic) { new_topic.merge(new_person) }

        it 'creates new endorsement and new person' do
          do_post @herby, '/api/v1/endorsements', new_person_and_topic
          expect_http response, :ok
          expect_response_and_model_json_to_match response, Endorse.last
        end

        it 'creates new endorserment and topic' do
          expect do
            do_post @herby, '/api/v1/endorsements', new_person_and_topic
          end.to change { Topic.count }.by(1)
        end
      end
    end

  end

  context 'Accept and Decline' do # rubocop:disable Metrics/BlockLength

    let(:t) { FactoryBot.create(:topic, name: 'Skeptic') }
    let(:e) { EndorsementService.create(@tisha, { endorsee_id: @herby.id, topic_id: t.id }) }

    describe 'accept' do

      it 'upates the status of the endorsement' do
        expect do
          do_put @herby, api_v1_accept_endorsement_path(e.from_node.id, e.to_node.id, e.topic)
          expect_response_and_model_json_to_match response, e.reload
        end.to change { e.status }.to :accepted
      end

      it "fails if endorsement doesn't exist" do
        do_put @herby, api_v1_accept_endorsement_path(e.to_node.id, e.from_node.id, e.topic)
        expect_http response, :not_found
      end

    end

    describe 'decline' do
      it 'upates the status of the endorsement' do
        expect do
          do_put @herby, api_v1_decline_endorsement_path(e.from_node.id, e.to_node.id, e.topic)
          expect_response_and_model_json_to_match response, e.reload
        end.to change { e.status }.to :declined
      end

      it "fails if endorsement doesn't exist" do
        do_put @herby, api_v1_accept_endorsement_path(e.to_node.id, e.from_node.id, e.topic)
        expect_http response, :not_found
      end

    end
  end
end
