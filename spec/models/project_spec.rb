require 'rails_helper'

describe Project do

  it "is invalid when newly created" do
    project = Project.new
    expect(project.name).to be_nil
    expect(project.description).to be_nil
    expect(project.owner).to be_nil

    expect(project.valid?(:update)).to be false
  end

  it "is invalid without name and description" do
    project = Project.new
    person = FactoryBot.create(:person)
    project.owner = person

    expect(project.name).to be_nil
    expect(project.description).to be_nil

    expect(project.valid?(:update)).to be false
  end

  context "Valid project" do
    before do 
      @project = FactoryBot.create(:project)
      @owner = @project.owner
    end

    it "is valid" do
      expect(@project.name).to_not be_nil
      expect(@project.description).to_not be_nil
      expect(@project.owner).to_not be_nil
      expect(@project).to be_valid
    end


    it "is inactive" do
      expect(@project.inactive?).to eq true
    end
  end

end
