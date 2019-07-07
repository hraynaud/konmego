require 'rails_helper'

describe Endorsement do
  before do 
    @topic1 = FactoryBot.create(:topic)
    @topic2 = FactoryBot.create(:topic)
    @endorsement = FactoryBot.create(:endorsement, topic: @topic1)
    @endorsee = @endorsement.endorsee
    @endorsee = @endorsement.endorsee
    @endorser = @endorsement.endorser
    @other = FactoryBot.create(:person)
  end

  it "is valid and pending" do
    expect(@endorsement).to be_valid
    expect(@endorsement.pending?).to eq true
  end

  it "prevents duplicate endorsements topic" do
    endorsement2 = FactoryBot.build(:endorsement, endorser: @endorser, endorsee: @endorsee, topic: @topic1)
    expect(endorsement2.save).to be false
    expect(Endorsement.size).to eq 1
  end

 it " establishes friend relationships" do
    expect(@endorser.friends_with?(@endorsee)).to eq true
  end

  it "establishes following relationships" do
    expect(@endorser.friends_with?(@endorsee)).to eq true
    expect(@endorser.follows?(@endorsee)).to eq true
    expect(@endorsee.followed_by?(@endorser)).to eq true
  end

  it "establishes edorser/endorsee relationships" do
    expect(@endorser.endorses?(@endorsee)).to eq true
    expect(@endorsee.endorsed_by?(@endorser)).to eq true
  end

  it "associates persons with the correct topic" do
    expect(@endorser.endorses_topic?(@topic1)).to eq true
    expect(@endorsee.has_endorsement_for_topic?(@topic1)).to eq true
  end

 #it "should be valid if email is provided instead of an existing user" do
    
  #end

  #it "should be invalid if no email or user is given" do
  #end

  #it "self.topic_endorsements_by_others" do
    ##it "should return the number of endorsements for the impressor in that subject" do
    ##i1 = FactoryBot.create(:endorsement)
    ##Endorsement.topic_endorsements_by_others(i1).count.should ==0
    ##user = FactoryBot.create(:user)
    ##i2 = FactoryBot.create(:endorsement, :topic => i1.topic, :admirer => user, :impressor => i1.impressor)
    ##Endorsement.topic_endorsements_by_others(i1).count.should ==1
    ##end
  #end

  #pending "self.prior_endorsers_exist" do
    #it "should return true for 1 record and false for > 1" do
      ##i1 = FactoryBot.create(:endorsement)
      ##Endorsement.prior_admirers_exist?(i1).should == false
      ##user = FactoryBot.create(:user)
      ##i2 = FactoryBot.create(:endorsement, :topic => i1.topic, :admirer => user, :impressor => i1.impressor)
      ##Endorsement.prior_admirers_exist?(i1).should == true
    #end
  #end

  #pending "#follow_each_other" do
    #it "should have do two-way following" do
      ##endorsement = FactoryBot.create(:endorsement).as_null_object
      ##endorsement.should_receive(:follow_impressor)
      ##endorsement.should_receive(:follow_admirer)
      ##endorsement.follow_each_other
    #end
  #end


end
