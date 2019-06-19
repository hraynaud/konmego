require 'rails_helper'

describe Endorsement do
  it "should be valid" do
    endorsement = FactoryBot.create(:endorsement)
    expect(endorsement).to be_valid
    expect(endorsement.pending?).to eq true
  end

  #it "should be valid if email is provided instead of an existing user" do
    #endorsement = FactoryGirl.build(:non_member_endorsement)
    #endorsement.should be_valid
    #endorsement.impressor_is_member?.should be_false #TODO refactor to observer test leave here for now.
  #end

  #it "should be invalid if no email or user is given" do
    #endorsement = FactoryGirl.build(:non_member_endorsement, :non_member_email=>nil)
    #endorsement.should_not be_valid
  #end

  #describe "self.topic_endorsements_by_others" do
    #it "should return the number of endorsements for the impressor in that subject" do
      #i1 = FactoryGirl.create(:endorsement)
      #Endorsement.topic_endorsements_by_others(i1).count.should ==0
      #user = FactoryGirl.create(:user)
      #i2 = FactoryGirl.create(:endorsement, :topic => i1.topic, :admirer => user, :impressor => i1.impressor)
      #Endorsement.topic_endorsements_by_others(i1).count.should ==1
    #end
  #end

  #describe "self.prior_admirers_exist" do
    #it "should return true for 1 record and false for > 1" do
      #i1 = FactoryGirl.create(:endorsement)
      #Endorsement.prior_admirers_exist?(i1).should == false
      #user = FactoryGirl.create(:user)
      #i2 = FactoryGirl.create(:endorsement, :topic => i1.topic, :admirer => user, :impressor => i1.impressor)
      #Endorsement.prior_admirers_exist?(i1).should == true
    #end
  #end

  #describe "#follow_each_other" do
    #it "should have do two-way following" do
      #endorsement = FactoryGirl.create(:endorsement).as_null_object
      #endorsement.should_receive(:follow_impressor)
      #endorsement.should_receive(:follow_admirer)
      #endorsement.follow_each_other
    #end

  #end


end
