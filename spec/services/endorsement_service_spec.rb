require 'rails_helper'
include TestDataHelper::Utils

describe EndorsementService do
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
    Endorsement.delete_all
    Topic.delete_all
    Invite.delete_all
    Identity.delete_all
    # clear_db
  end

  describe '.create' do
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
        EndorsementService.create(@p1, { endorsee_id: @p2.id, topic_id: @topic1.id })
        expect do
          EndorsementService.create(@p1, { endorsee_id: @p2.id, topic_id: @topic1.id })
        end.to raise_error(StandardError)
          .and change { @p2.endorsers.count }.by(0)
          .and change { Invite.count }.by(0)
      end
    end

    context 'new person' do
      it 'creates invite if user is new' do
        expect do
          EndorsementService.create(@p1,
                                    { topic_id: @topic1.id, first_name: 'new', last_name: 'lasty', email: 'a@b.com' })
        end.to change { Endorsement.count }.by(0)
                                           .and change { Invite.count }.by(1)
      end

      it 'fails with error if endorsement invite is missing email' do
        expect  do
          EndorsementService.create(@p1, { topic_id: @topic1.id, first_name: 'new', last_name: 'lasty' })
        end.to raise_error(ActiveGraph::Node::Persistence::RecordInvalidError)
          .and change { @p1.endorsees.count }.by(0)
          .and change { Invite.count }.by(0)
      end
    end

    context 'new topic' do
      it 'creates endorsement invite if topic params are valid' do
        expect do
          EndorsementService.create(@p1,
                                    { endorsee_id: @p2.id, first_name: 'new', last_name: 'lasty',
                                      new_topic_name: 'newsy', new_topic_category: 'topical' })
        end.to change { @p1.endorsees.count }.by(1)
                                             .and change { Topic.count }.by(0)
      end

      it "doesn't create endorsement invite if missing topic_name" do
        expect do
          EndorsementService.create(@p1, { endorsee_id: @p2.id, new_topic_category: 'topical' })
        end.to raise_error(StandardError)
          .and change { @p1.endorsees.count }.by(0)
      end

      # it "doesn't create endorsment if invalid" do
      #   expect do
      #     EndorsementService.create(@p1, { endorsee_id: @p2.id, new_topic_name: nil, new_topic_category: 'topical' })
      #   end.to raise_error(ActiveGraph::Node::Persistence::RecordInvalidError)
      #     .and change { Endorsement.count }.by(0)
      # end
    end

    context 'new person and new topic' do
      it 'creates endorsement and new invitation' do
        expect do
          EndorsementService.create(@p1,
                                    { new_topic_name: 'newsy', new_topic_category: 'topical', first_name: 'new',
                                      last_name: 'lasty', email: 'a@b.com' })
        end.to change { Invite.count }.by(1)
                                      .and change { Topic.count }.by(0)
      end
    end
  end

  describe 'accept' do
    before do
      @endorsement_invite = FactoryBot.create(:invite,:with_topic,:with_member)
      @p1 = @endorsement_invite.sender
      @p2 = @endorsement_invite.receiver
    end

    it 'creates Friendship' do
      expect do
        EndorsementService.accept(@endorsement_invite)
      end
        .to change {
              @p1.contacts.count
            }.by(1)
        .and change { @p2.contacts.count }.by(1)
    end

    pending 'has endorser follow endorsee' do
      expect do
        EndorsementService.accept(@e)
      end.to change { @p1.follows?(@p2) }.to(true)
    end
  end
end
