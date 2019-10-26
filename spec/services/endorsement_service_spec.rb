require 'rails_helper'

describe EndorsementService do
  let(:new_endorsee){{newPerson: {first: "Got", last: "Skillz", email: "goat@skillz.com"}}}
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
    let(:all_preexisting){{endorserId: @p1.id, endorseeId: @p2, topicId: @topic1}}

    let(:new_topic){ {newTopic: {name: "My New Topic"}} }

    it "creates endorsement" do
      expect{
        EndorsementService.create(all_preexisting)
      }.to change{Endorsement.count}.by(1)
    end


    it "doesn't have endorsee follow endorser" do
      EndorsementService.create(all_preexisting)
      expect(@p2.follows?(@p1)).to be false
    end


    context "new topic" do
      it "creates endorsement and new topic node" do
        expect{
          EndorsementService.create({endorserId: @p1.id, endorseeId: @p2}.merge new_topic)
        }.to change{Endorsement.count}.by(1)
          .and change{Topic.count}.by(1)
      end
    end
  end

  describe ".create_for_new_person_and_topic" do

    let(:params){ new_endorsee.merge({endorserId: @p1.id,}) }

    it "creates endorsement and new person node" do
      expect{
        EndorsementService.create(params)
      }.to change{Endorsement.count}.by(1)
        .and change{Topic.count}.by(1)
        .and change{Person.count}.by(1)
    end
  end


  describe ".create_for_new_person_node" do
    let(:new_endorsee_only){ new_endorsee.merge({endorserId: @p1, topicId: @topic1}) }

    it "creates endorsement and new person node" do
      expect{
        EndorsementService.create(new_endorsee_only)
      }.to change{Endorsement.count}.by(1)
        .and change{Person.count}.by(1)
    end

    it "newly created person node is not a member" do
      endorsement = EndorsementService.create(new_endorsee_only)
      expect(endorsement.endorsee.is_member?).to be false
    end

    it "fails with error if new person is invalid" do
      new_endorsee_only[:newPerson][:email] = nil

      expect{
        EndorsementService.create(new_endorsee_only)
      }.to change{Endorsement.count}.by(0)
        .and change{Person.count}.by(0)
    end

    it "fails with error if endorsment duplicated" do
      EndorsementService.create(new_endorsee_only)
      expect{
        EndorsementService.create(new_endorsee_only)
      }.to change{Endorsement.count}.by(0)
        .and change{Person.count}.by(0)
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
