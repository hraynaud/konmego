require 'rails_helper'

describe EndorsementService do
  before do
    @p1 = FactoryBot.create(:person)
    @p2 = FactoryBot.create(:person)
    @topic1 = FactoryBot.create(:topic)
  end

  describe ".create_for_existing_person_node" do
    it "creates endorsement" do
      expect{
        EndorsementService.create_for_existing_person_node(@p1, @p2, @topic1)
      }.to change{Endorsement.count}.by(1)
    end

    it "creates Friendship" do
      expect{
        EndorsementService.create_for_existing_person_node(@p1, @p2, @topic1)
      }.to change{@p1.contacts.count}.by(1)
        .and change{@p2.contacts.count}.by(1)
    end

    it "has endorser follow endorsee" do
      expect{
        EndorsementService.create_for_existing_person_node(@p1, @p2, @topic1)
      }.to change{@p1.follows?(@p2)}.to(true)
    end

    it "doesn't have endorsee follow endorser" do
      EndorsementService.create_for_existing_person_node(@p1, @p2, @topic1)
      expect(@p2.follows?(@p1)).to be false
    end
  end

  describe ".create_for_new_person_node" do
    let(:new_node){{first_name: "Got", last_name: "Skillz", email: "goat@skillz.com"}}

    it "creates endorsement and new person node" do
      expect{
        EndorsementService.create_for_new_person_node(@p1, new_node, @topic1)
      }.to change{Endorsement.count}.by(1)
        .and change{Person.count}.by(1)
    end

    it "newly created person node is not a member" do
      endorsement = EndorsementService.create_for_new_person_node(@p1, new_node, @topic1)
      expect(endorsement.endorsee.is_member?).to be false
    end
  end
end
