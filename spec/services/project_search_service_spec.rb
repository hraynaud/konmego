require 'set'
require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Projects

describe ProjectSearchService do
  before(:all) do
    setup_relationship_data
    setup_projects
  end

  after(:all) do
    clear_db
  end

  describe "By Topic" do
    let(:topic) {"Singing"}

    describe ".all_by_topic" do
      it "finds all projects by topic" do
        expect(ProjectSearchService.all_by_topic(topic).to_set).to eq [@vocalist_project, @vocalist_project2 ].to_set
      end
    end

    describe ".all_by_topic_and_visibility" do
      it "doesn't find projects with default private visibility" do
        expect(ProjectSearchService.all_by_topic_and_visibility(topic).to_set).to eq [@vocalist_project2].to_set
      end

      it "finds projects by specified visibility" do
        expect(ProjectSearchService.all_by_topic_and_visibility(topic, :public).to_set).to eq [@vocalist_project2 ].to_set
      end

      it "does not return private projects when asked explicitly" do
        expect(ProjectSearchService.all_by_topic_and_visibility(topic, :private).to_set).to eq [].to_set
      end

      it "finds nothing if visbility option is invalid" do
        expect(ProjectSearchService.all_by_topic_and_visibility(topic, :blahddblah)).to eq []
      end
    end
  end

  describe ".find_friend_projects" do
    it "finds projects of friends" do
      expect(ProjectSearchService.find_friend_projects(@sar)).to eq [@chef_project]
      expect(ProjectSearchService.find_friend_projects(@herby).to_set).to eq [@chef_project, @dining_project].to_set
      expect(ProjectSearchService.find_friend_projects(@fauzi).to_set).to eq [@culinary_project, @dj_project].to_set
      expect(ProjectSearchService.find_friend_projects(@elsa)).to eq []
    end

    it "finds projects of friends  by topic" do
      expect(ProjectSearchService.find_friend_projects_by_topic(@fauzi,@djing.name)).to eq [@dj_project]
    end
  end

  describe ".find_all_contact_projects" do
    it " find projects across friends network at default depth" do
      expect(ProjectSearchService.find_all_contact_projects(@vince).to_set).to eq [@chef_project, @dining_project ].to_set
    end

    it " find projects across friends network at custom depth" do
      expect(ProjectSearchService.find_all_contact_projects(@vince, 5).to_set).to eq [@chef_project, @dining_project, @culinary_project, @vocalist_project, @dj_project].to_set
    end
  end

  describe ".find_all_contact_projects_by_topic" do
    it " find projects across friends network at default depth" do
      expect(ProjectSearchService.find_all_contact_projects_by_topic(@vince, @cooking.name).to_set).to eq [@chef_project, @dining_project].to_set
    end

    it " find projects across friends network at custom depth" do
      expect(ProjectSearchService.find_all_contact_projects_by_topic(@vince, @djing.name, 5).to_set).to eq [@dj_project].to_set
    end
  end


  describe ".find_all_contact_projects_by_topic_and_visibility" do
    it " find projects across friends network at custom depth" do
      pending "Method is wrong"
      expect(ProjectSearchService.find_all_contact_projects_by_topic_and_visibility(@vince, @cooking.name).to_set).to eq [@dj_project].to_set
    end
  end
end
