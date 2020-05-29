require 'rails_helper'

include TestDataHelper::Relationships
include TestDataHelper::Utils
describe Project do

  context "is invalid for update when" do
    it "newly created" do
      project = Project.new
      expect(project.name).to be_nil
      expect(project.description).to be_nil
      expect(project.owner).to be_nil
      expect(project.valid?(:update)).to be false
    end

    it "name is blank" do
      project = Project.new
      person = FactoryBot.create(:person)
      project.owner = person
      project.description = "My description"
      expect(project.name).to be_nil
      expect(project.valid?(:update)).to be false
    end

    it "description is blank" do
      project = Project.new
      person = FactoryBot.create(:person)
      project.owner = person
      project.name = "My name"
      expect(project.description).to be_nil
      expect(project.valid?(:update)).to be false
    end

    it "owner is nil" do
      project = Project.new
      project.name = "My name"
      project.description = "My description"
      project.obstacles = [Obstacle.new]
      expect(project.owner).to be_nil
      expect(project.valid?(:update)).to be false
    end

    it "topic is nil" do
      project = Project.new
      person = FactoryBot.create(:person)
      project.owner = person
      project.name = "My name"
      project.description = "My description"
      project.obstacles = [Obstacle.new]
      expect(project.topic).to be_nil
      expect(project.valid?(:update)).to be false
    end

    it "success criteria is empty" do
      project = Project.new
      person = FactoryBot.create(:person)
      project.owner = person
      project.name = "My name"
      project.description = "My description"
      expect(project.obstacles).to be_empty
      expect(project.valid?(:update)).to be false
    end


  end

  context "is Valid for update when" do
    before do 
      @project = FactoryBot.create(:project, :valid)
    end

    it "it has all required properties and associations" do
      expect(@project.valid?(:update)).to be true
    end

  end


  context "filtering projects" do
  before do 
    clear_db
    setup_relationship_data
  end
    skip "returns projects user" do
      expect(Project.filter(@franky).to_set).to eq [@culinary_project, @dj_project, @software_project].to_set
    end

    skip "returns project scoped by topic " do
      expect(Project.filter(person: @elsa, topic: "Cooking").to_set).to eq [@chef_project ].to_set
      expect(Project.filter(person: @franky, topic: "Software", min_visibility: :friends).to_set).to eq [ ].to_set
    end

    skip "returns project scoped by visibility" do
      expect(Project.filter(person: @franky, min_visibility: :friends).to_set).to eq [@culinary_project, @dj_project ].to_set
    end

  end
end

