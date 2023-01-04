require 'rails_helper'
describe RelationshipManager do

  before do 
    @topic1 = FactoryBot.create(:topic)
    @topic2 = FactoryBot.create(:topic)
    @endorsement = FactoryBot.create(:endorsement, topic: @topic1)
    @endorsee = @endorsement.endorsee
    @endorser = @endorsement.endorser
  end

  describe ".create_friendship_if_none_exists_for" do 

    it "Adds contacts relationships for both endorser and endorsee" do
      expect {
        RelationshipManager.create_friendship_if_none_exists_for(@endorsement)
      }.to change{@endorser.contacts.count}.by(1)
        .and change{@endorsee.contacts.count}.by(1)
    end

    pending "establishes friendship and following relationships" do
      RelationshipManager.create_friendship_if_none_exists_for(@endorsement)
      expect(@endorser.friends_with?(@endorsee)).to be true
      expect(@endorser.follows?(@endorsee)).to be true
      expect(@endorsee.followed_by?(@endorser)).to be true
      expect(@endorsee.follows?(@endorser)).to be false
    end

    it "it doesn't create friendship if one already exists" do
      RelationshipManager.create_friendship_if_none_exists_for(@endorsement)
      expect{
        FactoryBot.create(:endorsement, topic: @topic2, endorser: @endorser, endorsee: @endorsee)
      }.to change{@endorser.contacts.count}.by(0)
        .and change{@endorsee.contacts.count}.by(0)
    end

    it "it doesn't create friendship if one already exists when endorsee and endorsee are reversed" do
      RelationshipManager.create_friendship_if_none_exists_for(@endorsement)
      expect{
        FactoryBot.create(:endorsement, topic: @topic2, endorser: @endorsee, endorsee: @endorser)
      }.to change{@endorser.contacts.count}.by(0)
        .and change{@endorsee.contacts.count}.by(0)
    end
  end

end
