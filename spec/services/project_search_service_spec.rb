require 'set'
require 'rails_helper'
include RelationshipHelper

describe ProjectSearchService do
  before do
    setup_relationship_data
    setup_projects
  end

  describe ".find_projects_by_topic" do
    it "finds all projects by topic" do
      expect(ProjectSearchService.all_by_topic("Singing").to_set).to eq [@vocalist_project, @vocalist_project2, @songwriter_project].to_set
    end

    it "doesn't find projects with default private visibility" do
      expect(ProjectSearchService.find_by_topic_and_visibility("Singing").to_set).to eq [@vocalist_project2].to_set
    end

    it "finds projects by specified visibility" do
      expect(ProjectSearchService.find_by_topic_and_visibility("Singing", :public).to_set).to eq [@vocalist_project2 ].to_set
    end

    it "does not return private projects" do
      expect(ProjectSearchService.find_by_topic_and_visibility("Singing", :private).to_set).to eq [].to_set
    end

    it "finds nothing if visbility option is invalid" do
      expect(ProjectSearchService.find_by_topic_and_visibility("Singing", :blahddblah)).to eq []
    end

    it "finds projects of contacts" do
      expect(ProjectSearchService.find_friend_projects(@sar)).to eq [@chef_project]
      expect(ProjectSearchService.find_friend_projects(@herby)).to eq [@chef_project, @dining_project]
      expect(ProjectSearchService.find_friend_projects(@fauzi)).to eq [@dining_project2]
      expect(ProjectSearchService.find_friend_projects(@jean)).to eq []
    end

   #it "finds projects of contacts with specified isibility" do
      #expect(ProjectSearchService.find_friend_projects(@sar)).to eq [@chef_project]
    #end



    #it "doesn't find skill if skill outside of hops limit" do
    #expect(ProjectSearchService.find_contacts_connected_to_topic_for(@sar, "Singing", 2)).to eq []
    #end

  end


  def setup_projects
    @chef_project = FactoryBot.create(:project, :valid, name: "Find chef", topic: @cooking, owner: @elsa, visibility: :friends)
    @dining_project = FactoryBot.create(:project, :valid, name: "Find chef", topic: @cooking, owner: @fauzi, visibility: :friends)
    @dining_project2 = FactoryBot.create(:project, :valid, name: "Find chef", topic: @cooking, owner: @franky, visibility: :friends)
    @vocalist_project = FactoryBot.create(:project, :valid, name: "Find Vocalist", topic: @singing, owner: @jean)
    @vocalist_project2 = FactoryBot.create(:project, :valid, name: "Find Vocalist",  topic: @singing, visibility: :public)
    @songwriter_project = FactoryBot.create(:project, :valid, name: "Find Songwriter", topic: @singing)
  end


end
