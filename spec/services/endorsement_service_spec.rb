require 'rails_helper'

describe EndorsementService do
  let(:all_preexisting){ {endorser_id: @p1.id, endorsee_id: @p2, topic_id: @topic1} }
  let(:new_endorsee){ {new_person: {first: "Got", last: "Skillz", email: "goat@skillz.com"}} }
  let(:new_topic){ {new_topic: {name: "My New Topic"} } }
  let(:new_person_new_topic){ (new_endorsee.merge(new_topic)) }

  before do
    @p1 = FactoryBot.create(:person)
    @p2 = FactoryBot.create(:person)
    @topic1 = FactoryBot.create(:topic)
  end

  after do
    Person.delete_all
    Endorsement.delete_all
    Topic.delete_all
  end

  describe ".create" do

    context "all preexisting nodes" do

      it "creates succeeds" do
        expect{
          EndorsementService.create(all_preexisting)
        }.to change{Endorsement.count}.by(1)
      end


      specify " endorsee doesn't follow endorser" do
        EndorsementService.create(all_preexisting)
        expect(@p2.follows?(@p1)).to be false
      end
    end

    context  "new person" do
      let(:with_new_endorsee_others_existing){ new_endorsee.merge({endorser_id: @p1, topic_id: @topic1}) }

      it "creates endorsement and new person node" do
        expect{
          EndorsementService.create(with_new_endorsee_others_existing)
        }.to change{Endorsement.count}.by(1)
          .and change{Person.count}.by(1)
      end

      specify "newly created person is not a member" do
        endorsement = EndorsementService.create(with_new_endorsee_others_existing)
        expect(endorsement.endorsee.is_member?).to be false
      end

      it "fails with error if new person is invalid" do
        with_new_endorsee_others_existing[:new_person][:email] = nil

        expect{
          EndorsementService.create(with_new_endorsee_others_existing)

        }.to raise_error(Neo4j::ActiveNode::Persistence::RecordInvalidError)
          .and change{Endorsement.count}.by(0)
          .and change{Person.count}.by(0)
      end

      it "fails with error if endorsment duplicated" do
        EndorsementService.create(with_new_endorsee_others_existing)
        expect{
          EndorsementService.create(with_new_endorsee_others_existing)
        }.to raise_error(Neo4j::ActiveNode::Persistence::RecordInvalidError)
          .and change{Endorsement.count}.by(0)
          .and change{Person.count}.by(0)

      end
    end

    context "new topic" do
      it "creates endorsement and new topic if topic valid" do
        expect{
          EndorsementService.create({endorser_id: @p1.id, endorsee_id: @p2}.merge new_topic)
        }.to change{Endorsement.count}.by(1)
          .and change{Topic.count}.by(1)
      end

      it "doesn't create endorsment if invalid" do
        expect{
          new_topic[:new_topic][:name] = nil 
          EndorsementService.create({endorser_id: @p1.id, endorsee_id: @p2.id}.merge new_topic)
        }.to raise_error(Neo4j::ActiveNode::Persistence::RecordInvalidError)
          .and change{Endorsement.count}.by(0)
      end
    end

    context "new person and new topic" do
      let(:params){  (new_person_new_topic.merge({endorser_id: @p1.id}))  }

      it "creates endorsement and new person node" do
        expect{
          EndorsementService.create(params)
        }.to change{Endorsement.count}.by(1)
          .and change{Topic.count}.by(1)
          .and change{Person.count}.by(1)
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
