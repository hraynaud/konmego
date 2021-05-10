require 'set'
require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Utils

describe ProjectService do
  before(:all) do
    clear_db 
    @owner = FactoryBot.create(:member)
    @topic = FactoryBot.create(:topic)
    @obstacle = FactoryBot.create(:obstacle)
  end

  after(:all) do
    clear_db
  end

  describe ".create" do

    it "creates a new project" do
      expect{ ProjectService.create(@owner, project_params ) }.to change{Project.count}.by(1)
    end


    context "failures" do
      it "fails when missing required params" do
        expect{ ProjectService.create(@owner, project_params.except(:name))}
          .to raise_error(ActiveGraph::Node::Persistence::RecordInvalidError)
          .and change{Project.count}.by(0)
      end
    end

  end

  def project_params
    {
      name: "My project",
      description: "describes me to a t",
      start_date: 2.weeks.from_now,
      deadline: 4.weeks.from_now,
    }
  end

end



