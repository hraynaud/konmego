require 'rails_helper'

describe Project do

  context "Creation" do
    it "is invalid when newly created" do
      project = Project.new
      expect(project.name).to be_nil
      expect(project.description).to be_nil
      expect(project.owner).to be_nil
      expect(project.valid?(:update)).to be false
    end

    it "is invalid  without name " do
      project = Project.new
      person = FactoryBot.create(:person)
      project.owner = person
      project.description = "My description"
      expect(project.name).to be_nil
      expect(project.valid?(:update)).to be false
    end

    it "is invalid without description" do
      project = Project.new
      person = FactoryBot.create(:person)
      project.owner = person
      project.name = "My name"
      expect(project.description).to be_nil
      expect(project.valid?(:update)).to be false
    end

    it "is invalid without owner" do
      project = Project.new
      project.name = "My name"
      project.description = "My description"
      project.success_criteria = [SuccessCriterium.new]
      expect(project.owner).to be_nil
      expect(project.valid?(:update)).to be false
    end

    it "is invalid without success criteria" do
      project = Project.new
      person = FactoryBot.create(:person)
      project.owner = person
      project.name = "My name"
      project.description = "My description"
      expect(project.success_criteria).to be_empty
      expect(project.valid?(:update)).to be false
    end

    context "Valid" do
      context "on build" do
        before do 
          @project = FactoryBot.build(:project)
        end

        it "is valid" do
          expect(@project.name).to_not be_nil
          expect(@project.description).to_not be_nil
          expect(@project.owner).to_not be_nil
          expect(@project).to be_valid
          expect(@project.save).to be true
        end

        it "is inactive" do
          expect(@project.inactive?).to eq true
        end
      end

      context "on create" do

        it "is valid" do
          project = FactoryBot.create(:project)
          expect(project.save).to be false
        end

        it "is valid" do
          project = FactoryBot.create(:project, :valid)
          expect(project.save).to be true
        end
      end
    end
  end

end
