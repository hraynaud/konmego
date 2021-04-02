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

        expected_projects = project_names([@dj_project, @culinary_project])
        expect( project_names(search_by(@tisha, depth: 2))).to eq  expected_projects
        expect(project_names(search_by(@vince, depth: 2))).to eq empty_set
        expect(project_names(search_by(@vince, depth: 3))).to eq  expected_projects 

      end

      it "includes self projects" do
        expect(project_names(search_by(@elsa))).to eq project_names([ @acting_project, @chef_project])
      end
      
      it "excludes self private projects" do
      expect(project_names(search_by(@franky))).to eq project_names([@dining_project, @dj_project, @culinary_project, @acting_project])
      end


      it "finds projects belonging to friends at default depth" do
        expect(search_by(@vince).to_set).to eq  empty_set
        expect(project_names(search_by(@herby ))).to eq project_names([@dj_project, @culinary_project ])
      end

      it "ignores private projects" do
        expect(project_names(search_by(@sar))).to eq project_names([@chef_project, @acting_project, @dj_project, @culinary_project, @app_project])
      end
    end

    context "by topic" do
      it "finds projects by topic" do
        expect(project_names(search_by(@herby, { topic: @cooking.id}))).to eq project_names([@culinary_project])
      end

      it "finds projects by depth and topic" do
        expect(project_names(search_by(@herby, {depth: 2, topic: @cooking.id}))).to eq project_names([@dining_project, @culinary_project ])
        expect(project_names(search_by(@herby, {depth: 3, topic: @cooking.id}))).to eq project_names([@chef_project, @dining_project, @culinary_project ])
      end

    end

    context "by friend" do
      it "finds projects by friend" do
        expect(project_names(search_by(@sar, {friend: @jean}))).to eq project_names([ @app_project])
      end

      it "finds projects by friend and topic" do
        expect(project_names(search_by(@herby, {friend: @franky, topic: @cooking.id}))).to eq project_names([ @culinary_project])
      end

      it "returns nothing if user and friend are not directly connected" do
        expect(project_names(search_by(@tisha, {friend: @elsa, topic: @cooking.id}))).to eq empty_set
      end
    end
  end


  def all_projects
    [@chef_project, @dining_project, @culinary_project, @vocalist_project, @vocalist_project2,  @songwriter_project, @dj_project]
  end

  def project_names projects
    projects.map(&:name).to_set
  end

  def empty_set
    [].to_set
  end

  def search_by user, params = {}
    ProjectSearchService.search(user, params)
  end
end
