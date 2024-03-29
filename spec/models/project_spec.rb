require 'rails_helper'
include TestDataHelper::Utils

describe Project do
  context "for single project" do

    before do
      clear_db
    end

    context "is invalid for update when" do
      let(:project){Project.new}

      after do
        expect(project.valid?(:update)).to be false
      end

      it "owner is nil" do
        project.name = "My name"
        project.description = "My description"
        expect(project.owner).to be_nil
      end

      context "has owner" do

        before do
          person = FactoryBot.create(:member)
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

        #it "has no topic" do
          #project.name = "My name"
          #project.description = "My description"
          #project.obstacles = [Obstacle.new]
          #expect(project.topic).to be_nil
        #end

        #it "has no obstacles" do
          #project.name = "My name"
          #project.description = "My description"
          #expect(project.obstacles).to be_empty
        #end

      end
    end

    context "activation blocked" do
      before do
        @project = FactoryBot.create(:project, :valid)
        @project.status = "active"

      end

      pending "it is missing roadblocks" do
        @project.roadblocks = []
        expect(@project.valid?(:update)).to be false
      end

      it "it missing description" do
        @project.description = nil
        expect(@project.valid?(:update)).to be false
      end

      it "it missing topc" do
        @project.topic = nil
        expect(@project.valid?(:update)).to be false
      end

      it "it missing start_date" do
        @project.start_date = nil
        expect(@project.valid?(:update)).to be false
      end

      it "it missing deadline" do
        @project.deadline = nil
        expect(@project.valid?(:update)).to be false
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
end
