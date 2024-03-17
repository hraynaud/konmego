require 'rails_helper'
include TestDataHelper::Utils

describe EndorsementService do # rubocop:disable Metrics/BlockLength
  let(:new_endorsee) { { first_name: 'Got', last_name: 'Skillz' } }
  let(:new_topic) { { name: 'My New Topic' } }
  let(:new_person_new_topic) { new_endorsee.merge(new_topic) }

  before do
    # clear_db
    @p1 = FactoryBot.create(:member)
    @p2 = FactoryBot.create(:member)
    @topic1 = FactoryBot.create(:topic)
    @topic2 = FactoryBot.create(:topic)
  end

  after do
    Person.delete_all
    Topic.delete_all
    # clear_db
  end

  describe '.create' do # rubocop:disable Metrics/BlockLength
    context 'all preexisting nodes' do
      it 'create succeeds' do
        EndorsementService.create(@p1, { endorsee_id: @p2.id, topic_id: @topic1.id })
        expect(@p2.endorsed_by?(@p1)).to be true
        expect(@p1.endorsed_by?(@p2)).to be false
      end

      specify " endorsee doesn't follow endorser" do
        EndorsementService.create(@p1, { endorsee_id: @p2.id, topic_id: @topic1.id })
        expect(@p2.follows?(@p1)).to be false
      end

      it 'fails with error if endorsment duplicated' do
        endorsement = EndorsementService.create(@p1, { endorsee_id: @p2.id, topic_id: @topic1.id })
        endorsement.accept!
        expect do
          EndorsementService.create(@p1, { endorsee_id: @p2.id, topic_id: @topic1.id })
        end.to raise_error(StandardError)
          .and change { @p2.endorsers.count }.by(0)
          .and change { Invite.count }.by(0)
      end
    end

    context 'new person' do
      it 'creates endorsement and new person if user is new' do
        expect do
          e = EndorsementService.create(@p1,
                                        { topic_id: @topic1.id, first_name: 'new', last_name: 'lasty',
                                          email: 'a@b.com' })
          expect(e.topic).to eq(@topic1)
        end.to change { Person.count }.by(1)
                                      .and change { Topic.count }.by(0)
                                                                 .and change {
                                                                        @p1.reload.endorsees.count
                                                                      }.by(1) # TODO: this shouold be pending_endorsees

      end

      it 'fails with error if endorsement invite is missing email' do
        expect  do
          EndorsementService.create(@p1, { topic_id: @topic1.id, first_name: 'new', last_name: 'lasty' })
        end.to raise_error(StandardError)
          .and change { @p1.endorsees.count }.by(0)
      end
    end

    context 'new topic' do
      it 'creates endorsement if topic params are valid' do
        mock_like_terms('newsy')
        expect do
          EndorsementService.create(@p1,
                                    { endorsee_id: @p2.id, first_name: 'new', last_name: 'lasty',
                                      new_topic_name: 'newsy', new_topic_category: 'topical' })
        end.to change { @p1.reload.endorsees.count }.by(1)
                                                    .and change { Topic.count }.by(1)
      end

      it "doesn't create endorsement if missing topic_name" do
        expect do
          EndorsementService.create(@p1, { endorsee_id: @p2.id, new_topic_category: 'topical' })
        end.to raise_error(StandardError)
          .and change { @p1.endorsees.count }.by(0)
      end

    end

    context 'new person and new topic' do
      it 'creates endorsement and new person' do
        mock_like_terms('newsy')
        expect do
          EndorsementService.create(@p1,
                                    { new_topic_name: 'newsy', new_topic_category: 'topical', first_name: 'new',
                                      last_name: 'lasty', email: 'a@b.com' })
        end.to change { Person.count }.by(1)
                                      .and change { Topic.count }.by(1)
      end
    end
  end

  describe 'accept' do

    it 'updates status and creates contact' do

      expect(RelationshipManager).to receive(:create_friendship_if_none_exists_for).and_call_original

      @endorsement = EndorsementService.create(@p1, { endorsee_id: @p2.id, topic_id: @topic1.id })
      expect do
        EndorsementService.accept(@endorsement, @p2)
      end.to (change { @endorsement.status }.to :accepted)
        .and change { @p1.contacts.count }.by(1)
        .and change { @p2.contacts.count }.by(1)

    end

  end

  describe 'decline' do

    it 'has endorser follow endorsee' do
      @endorsement = EndorsementService.create(@p1, { endorsee_id: @p2.id, topic_id: @topic1.id })
      expect do
        EndorsementService.decline(@endorsement, @p2)
      end.to change { @p1.reload.pending_endorsees.count }.by(-1)
    end
  end

end
