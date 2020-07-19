require 'rails_helper'
include TestDataHelper::Utils

describe Endorsement do
  let(:endorsement){Endorsement.new}

  before do 
    clear_db
    @topic1 = FactoryBot.create(:topic)
    @topic2 = FactoryBot.create(:topic)

  end

  after do
  end

  context "invalid when incomplete" do
    it "is invalid when new" do
     expect(endorsement.persisted?).to be false
    end

    it "is invalid without endorsee" do
      endorsement.endorser = @endorser
      endorsement.topic = @topic1
      expect(endorsement.valid?(:update)).to be false
    end

    it "is invalid without endorser" do
      endorsement.endorsee = @endorsee
      endorsement.topic = @topic1
      expect(endorsement.valid?(:update)).to be false
    end

    it "is invalid without topic" do
      endorsement.endorsee = @endorsee
      endorsement.endorser = @endorser
      expect(endorsement.valid?(:update)).to be false
    end

  end

  context "valid" do

    before do 
      @endorsement = FactoryBot.create(:endorsement, topic: @topic1)
      @endorsee = @endorsement.endorsee
      @endorser = @endorsement.endorser
    end

    it "is valid and pending" do
      expect(@endorsement).to be_valid
      expect(@endorsement.pending?).to eq true
    end

    it "prevents duplicate endorsements topic" do
      endorsement2 = FactoryBot.build(:endorsement, endorser: @endorser, endorsee: @endorsee, topic: @topic1)
      expect(endorsement2.valid?).to be false
      expect{endorsement2.save}.to change{Endorsement.size}.by(0)
    end

    it "establishes edorser/endorsee relationships" do
      expect(@endorser.endorses?(@endorsee)).to eq true
      expect(@endorsee.endorsed_by?(@endorser)).to eq true
    end

    it "associates persons with the correct topic" do
      expect(@endorser.endorses_topic?(@topic1)).to eq true
      expect(@endorsee.has_endorsement_for_topic?(@topic1)).to eq true
    end
  end

end
