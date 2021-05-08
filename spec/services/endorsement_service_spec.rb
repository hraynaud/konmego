require 'rails_helper'

describe EndorsementService do
  let(:new_endorsee){{first_name: "Got", last_name: "Skillz"}} 
  let(:new_topic){{name: "My New Topic"}}
  let(:new_person_new_topic){ (new_endorsee.merge(new_topic)) }

  before do
    @p1 = FactoryBot.create(:member)
    @p2 = FactoryBot.create(:member)
    @topic1 = FactoryBot.create(:topic)
  end

  after do
    Person.delete_all
    Endorsement.delete_all
    Topic.delete_all
    Invite.delete_all
  end

  describe ".create" do

    context "all preexisting nodes" do
      it "create succeeds" do
        expect{
          EndorsementService.create(@p1, {endorsee_id: @p2.id, topic_id: @topic1.id})
        }.to change{Endorsement.count}.by(1)
      end

      specify " endorsee doesn't follow endorser" do
        EndorsementService.create(@p1, {endorsee_id: @p2.id, topic_id: @topic1.id})
        expect(@p2.follows?(@p1)).to be false
      end

    end


    context  "new person" do
      it "creates invite if user is new" do
        expect{
          EndorsementService.create(@p1, {topic_id: @topic1.id, first_name: "new", last_name: "lasty", email: "a@b.com"})
        }.to change{Endorsement.count}.by(0)
          .and change{Invite.count}.by(1)
      end


      it "fails with error if invite is invalid" do
        expect{
          EndorsementService.create(@p1, {topic_id: @topic1.id, first_name: "new", last_name: "lasty"})

        }.to raise_error(ActiveGraph::Node::Persistence::RecordInvalidError)
          .and change{Endorsement.count}.by(0)
          .and change{Invite.count}.by(0)
      end

      it "fails with error if endorsment duplicated" do
        EndorsementService.create(@p1, {endorsee_id: @p2.id, topic_id: @topic1.id})
        expect{
          EndorsementService.create(@p1, {endorsee_id: @p2.id, topic_id: @topic1.id})
        }.to raise_error(ActiveGraph::Node::Persistence::RecordInvalidError)
          .and change{Endorsement.count}.by(0)
          .and change{Invite.count}.by(0)

      end
    end

    context "new topic" do
      it "creates endorsement and new topic if topic valid" do
        expect{
          EndorsementService.create(@p1, {endorsee_id: @p2.id, new_topic_name: "newsy", new_topic_category: "topical"})
        }.to change{Endorsement.count}.by(1)
          .and change{Topic.count}.by(1)
      end

      it "doesn't create endorsment if missing topic" do
        expect{
          EndorsementService.create(@p1, {endorsee_id: @p2.id, new_topic_category: "topical"})
        }.to raise_error(ActiveGraph::Node::Persistence::RecordInvalidError)
          .and change{Endorsement.count}.by(0)
      end

      it "doesn't create endorsment if invalid" do
        expect{
          EndorsementService.create(@p1, {endorsee_id: @p2.id, new_topic_name: nil, new_topic_category: "topical"})
        }.to raise_error(ActiveGraph::Node::Persistence::RecordInvalidError)
          .and change{Endorsement.count}.by(0)
      end
    end

    context "new person and new topic" do

      it "creates endorsement and new invitation" do
        expect{
          EndorsementService.create(@p1, {new_topic_name: "newsy", new_topic_category: "topical", first_name: "new", last_name: "lasty", email: "a@b.com"})
        }.to change{Endorsement.count}.by(0)
          .and change{Invite.count}.by(1)
          .and change{Topic.count}.by(1)
      end
    end

  end

  describe "accept" do
    before do
      @e = FactoryBot.create(:endorsement)
      @p1 = @e.endorser
      @p2 = @e.endorsee
    end

    it "creates Friendship" do
      expect{
        EndorsementService.accept(@e)
      }.to change{@p1.contacts.count}.by(1)
        .and change{@p2.contacts.count}.by(1)
    end

    it "has endorser follow endorsee" do
      expect{
        EndorsementService.accept(@e)
      }.to change{@p1.follows?(@p2)}.to(true)
    end
  end

end
