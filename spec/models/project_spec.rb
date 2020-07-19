require 'rails_helper'

include TestDataHelper::Relationships
include TestDataHelper::Utils
describe Project do
  before do
    clear_db
  end


  context "is invalid for update when" do
    let(:project){Project.new}

    before do
      clear_db
    end

    after do
      expect(project.valid?(:update)).to be false
    end

    it "owner is nil" do
      project.name = "My name"
      project.description = "My description"
      project.obstacles = [Obstacle.new]
      expect(project.owner).to be_nil
    end

    context "has owner" do 

      before do 
        person = FactoryBot.create(:person)
        project.owner = person
      end

      it "has blank name" do
        project.description = "My description"
        expect(project.name).to be_nil
      end

      it "has blank description" do
        project.name = "My name"
        expect(project.description).to be_nil
      end

      it "has no topic" do
        project.name = "My name"
        project.description = "My description"
        project.obstacles = [Obstacle.new]
        expect(project.topic).to be_nil
      end

      it "has no obstacles" do
        project.name = "My name"
        project.description = "My description"
        expect(project.obstacles).to be_empty
      end

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

    skip "returns projects by user" do
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

