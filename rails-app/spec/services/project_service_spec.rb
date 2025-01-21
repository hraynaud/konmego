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
      expect{ ProjectService.create(@owner, create_params ) }.to change{Project.count}.by(1)
    end


    context "failures" do
      it "fails when missing required params" do
        expect{ ProjectService.create(@owner, create_params.except(:name))}
          .to raise_error(ActiveGraph::Node::Persistence::RecordInvalidError)
          .and change{Project.count}.by(0)
      end
    end

  end

  describe ".update" do

    context "success" do

      context "normal update" do
        before do
          @project = FactoryBot.create(:project )
          @project.description  << "Chamge of placens"
        end

        it "updates field" do
          ProjectService.update(@project, update_params )
        end

        it "changes topic" do
          topic =  FactoryBot.create(:topic)
          @project.topic = topic
          ProjectService.update(@project, update_params )
          expect(@project.topic_name).to eq(topic.name)
        end
      end

      context "activatable" do
        before do
          @project = FactoryBot.create(:project, :creatable)
        end

        it "activates project" do
          @project.status = 'active'
          ProjectService.update(@project, update_params )
        end
      end
    end

    context "failures" do
      it "fails when missing required params" do
      end
    end

  end


  def create_params
    {
      name: "My project",
      description: "describes me to a t",
      start_date: 2.weeks.from_now,
      deadline: 4.weeks.from_now,
    }
  end

  def update_params
    {

    }
  end
end
