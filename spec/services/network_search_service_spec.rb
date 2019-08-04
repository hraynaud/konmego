require 'set'
require 'rails_helper'

describe NetworkSearchService do
  before do
    create_users
    create_topics
    setup_social_graph
    create_endorsements
    set_endorsement_statuses
  end

  describe ".find_skill" do
    it "finds skill through contacts" do
      expect(NetworkSearchService.find_skill(@fauzi, "Singing").to_set).to eq [@tisha].to_set
    end

    it "finds skill directly and through contacts" do
      expect(NetworkSearchService.find_skill(@fauzi, "Cooking").to_set).to eq [@fauzi, @tisha].to_set
    end

    it "finds skill through arbitrary number of contacts" do
      expect(NetworkSearchService.find_skill(@sar, "Singing", 3)).to eq [@tisha]
    end

    it "doesn't find skill if skill outside of hops limit" do
      expect(NetworkSearchService.find_skill(@sar, "Singing", 2)).to eq []
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
    RelationshipManager.befriend @herby, @tisha
    RelationshipManager.befriend @tisha, @kendra
    RelationshipManager.befriend @jean, @herby
    RelationshipManager.befriend @fauzi, @herby
    RelationshipManager.befriend @fauzi, @tisha
    RelationshipManager.befriend @tisha, @vince
    RelationshipManager.befriend @kendra, @vince
    RelationshipManager.befriend @jean, @herby
    RelationshipManager.befriend @herby,  @elsa 
    RelationshipManager.befriend @franky,  @fauzi
    RelationshipManager.befriend @sar, @elsa
  end

  def create_endorsements
    @accepted = []
    @pending = []
    @declined = []

    @accepted << EndorsementService.create_for_existing_person_node(@fauzi, @franky, @cooking)
    @accepted << EndorsementService.create_for_existing_person_node(@tisha, @kendra, @singing)
    @accepted << EndorsementService.create_for_existing_person_node(@tisha, @kendra, @cooking)

    @declined << EndorsementService.create_for_existing_person_node(@vince, @jean, @composer)
    @pending << EndorsementService.create_for_existing_person_node(@elsa, @sar, @acting)

  end

  def set_endorsement_statuses
    @accepted.each do |e|
      EndorsementService.accept(e)
    end

    @declined.each do |e|
      EndorsementService.decline(e)
    end
  end

end
