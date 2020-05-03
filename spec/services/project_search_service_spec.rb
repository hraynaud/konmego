require 'set'
require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils

describe ProjectSearchService do
  before(:all) do
    setup_relationship_data
    setup_projects
  end

  after(:all) do
    clear_db
  end

  describe ".search" do

    context "friend projects" do
      it "finds projects belonging to contacts at specified depth" do
        expect(ProjectSearchService.search(@vince, depth: 5).to_set).to eq  [@chef_project, @dining_project, @culinary_project, @dj_project].to_set
        expect(ProjectSearchService.search(@vince, depth: 3).to_set).to eq  [@chef_project, @dining_project].to_set
      end

      it "finds projects belonging to friends at default depth" do
        expect(ProjectSearchService.search(@vince).to_set).to eq  [].to_set
      end

      it "ignores private projects" do
        expect(ProjectSearchService.search(@sar).to_set).to eq  [@chef_project, @programming_project].to_set
      end
    end

    context "by topic" do
      it "finds projects by topic" do
        expect(ProjectSearchService.search(@herby, { topic: "Cooking"}).to_set).to eq [@chef_project, @dining_project].to_set
      end
      it "finds projects by depth and topic" do
        expect(ProjectSearchService.search(@herby, {depth: 2, topic: "Cooking"}).to_set).to eq [ @chef_project,@dining_project, @culinary_project ].to_set
      end
    end

    context "by friend" do
      it "finds projects by friend" do
        expect(ProjectSearchService.search(@herby, {friend: @elsa}).to_set).to eq [ @chef_project].to_set
      end

      it "finds projects by friend and topic" do
        expect(ProjectSearchService.search(@herby, {friend: @elsa, topic: "Cooking"}).to_set).to eq [ @chef_project].to_set
      end

      it "returns nothing if user and friend are not directly connected" do
        expect(ProjectSearchService.search(@tisha, {friend: @elsa, topic: "Cooking"}).to_set).to eq [].to_set
      end
    end
  end


  def all_projects
    [@chef_project, @dining_project, @culinary_project, @vocalist_project, @vocalist_project2,  @songwriter_project, @dj_project]
  end
end
