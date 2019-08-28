require 'rails_helper'

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
      project.success_criteria = [SuccessCriterium.new]
      expect(project.owner).to be_nil
      expect(project.valid?(:update)).to be false
    end

    it "topic is nil" do
      project = Project.new
      person = FactoryBot.create(:person)
      project.owner = person
      project.name = "My name"
      project.description = "My description"
      project.success_criteria = [SuccessCriterium.new]
      expect(project.topic).to be_nil
      expect(project.valid?(:update)).to be false
    end

    it "success criteria is empty" do
      project = Project.new
      person = FactoryBot.create(:person)
      project.owner = person
      project.name = "My name"
      project.description = "My description"
      expect(project.success_criteria).to be_empty
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
end

