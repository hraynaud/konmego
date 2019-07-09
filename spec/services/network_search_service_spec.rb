require 'rails_helper'

describe NetworkSearchService do
  before do
    create_users
    create_topics
    setup_social_graph
    create_endorsements
  end

  describe ".find_skill" do
    it "finds skill in network" do
      expect(NetworkSearchService.find_skill(@fauzi, "Singing")).to eq [@tisha]
    end
  end

  def create_users
    @herby, @tisha, @franky, @fauzi, @kendra, @sar, @elsa, @vince, @jean = %w(
      herby tisha franky fauzi kendra sar elsa vince jean
    ).map do |fname|
      FactoryBot.create(:person, first_name: fname.titleize, last_name: "Skillz")
    end
  end

  def create_topics
    @cooking, @fencing, @acting, @djing, @singing, @design, @composer = %w(
      cooking fencing acting djing singing design composer
    ).map do |skill|
      FactoryBot.create(:topic, name: skill.titleize )
    end
  end

  def setup_social_graph
    @herby.befriend @tisha
    @tisha.befriend @kendra
    @jean.befriend @herby
    @fauzi.befriend @herby
    @fauzi.befriend @tisha
    @tisha.befriend @vince
    @kendra.befriend @vince
    @jean.befriend @herby
    @herby.befriend @elsa 
    @franky.befriend @fauzi
    @sar.befriend @elsa
  end

  def create_endorsements
    EndorsementService.create_for_existing_person_node(@fauzi, @franky, @cooking)
    EndorsementService.create_for_existing_person_node(@tisha, @kendra, @singing)
    EndorsementService.create_for_existing_person_node(@elsa, @sar, @acting)
  end

end
