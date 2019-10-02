module TestDataHelper
  module Relationships

    def setup_relationship_data
      create_users
      create_topics
      setup_social_graph
      create_endorsements
      set_endorsement_statuses
    end

    def create_users
      @herby, @tisha, @franky, @fauzi, @kendra, @sar, @elsa, @vince, @jean = %w(
      herby tisha franky fauzi kendra sar elsa vince jean
      ).map do |fname|
        FactoryBot.create(:person, first_name: fname.titleize, last_name: "Skillz")
      end
    end

    def create_topics
      @cooking, @fencing, @acting, @djing, @singing, @design, @composer = %w(
      cooking fencing acting djing singing design composer
      ).map do |skill|
        FactoryBot.create(:topic, name: skill.titleize )
      end
    end

    def setup_social_graph
      RelationshipManager.befriend @herby, @tisha
      RelationshipManager.befriend @herby,  @elsa 
      RelationshipManager.befriend @jean, @herby
      RelationshipManager.befriend @fauzi, @herby

      RelationshipManager.befriend @tisha, @kendra
      RelationshipManager.befriend @tisha, @vince

      RelationshipManager.befriend @franky,  @fauzi

      RelationshipManager.befriend @kendra, @vince
      RelationshipManager.befriend @sar, @elsa
    end

    def create_endorsements
      @accepted = []
      @pending = []
      @declined = []

      @accepted << EndorsementService.create_for_existing_person_node(@fauzi, @franky, @cooking)
      @accepted << EndorsementService.create_for_existing_person_node(@tisha, @kendra, @singing)
      @accepted << EndorsementService.create_for_existing_person_node(@tisha, @kendra, @cooking)

      @declined << EndorsementService.create_for_existing_person_node(@jean, @vince, @composer)
      @pending << EndorsementService.create_for_existing_person_node(@elsa, @sar, @acting)

    end

    def set_endorsement_statuses
      @accepted.each do |e|
        EndorsementService.accept(e)
      end

      @declined.each do |e|
        EndorsementService.decline(e)
      end
    end
  end

  module Utils
    def clear_db
      Neo4j::ActiveBase.current_session.query('MATCH (n) WHERE NOT n:`Neo4j::Migrations::SchemaMigration`
DETACH DELETE n')
    end
  end

  module Projects
    def setup_projects
      @chef_project = FactoryBot.create(:project, :valid, name: "Find chef 1", topic: @cooking, owner: @elsa, visibility: :friends)
      @dining_project = FactoryBot.create(:project, :valid, name: "Fine Dining", topic: @cooking, owner: @fauzi, visibility: :friends)
      @culinary_project = FactoryBot.create(:project, :valid, name: "Culinary", topic: @cooking, owner: @franky, visibility: :friends)
      @vocalist_project = FactoryBot.create(:project, :valid, name: "The Voice", topic: @singing, owner: @jean)
      @vocalist_project2 = FactoryBot.create(:project, :valid, name: "The Range",  topic: @singing, visibility: :public)
      @songwriter_project = FactoryBot.create(:project, :valid, name: "Songwriter", topic: @fencing)
      @dj_project = FactoryBot.create(:project, :valid, name: "Find dj", topic: @djing, owner: @franky, visibility: :friends)
    end
  end


  module SampleResults

    def sars_cooking_network 
      {
        "nodes"=> [
          {"label"=>"Sar Skillz", "type"=>"Person", "id"=>293},
          {"label"=>"Tisha Skillz", "type"=>"Person", "id"=>287},
          {"label"=>"Cooking", "type"=>"Topic", "id"=>324},
          {"label"=>"Tisha Skillz Endorses someone for Cooking", "type"=>"Endorsement", "id"=>340},
          {"label"=>"Sar Skillz", "type"=>"Person", "id"=>293},
          {"label"=>"Fauzi Skillz", "type"=>"Person", "id"=>288},
          {"label"=>"Cooking", "type"=>"Topic", "id"=>324},
          {"label"=>"Fauzi Skillz Endorses someone for Cooking", "type"=>"Endorsement", "id"=>333}
        ],

        "links"=> [
          {"source"=>293, "target"=>314, "type"=>"KNOWS"},
          {"source"=>297, "target"=>314, "type"=>"KNOWS"},
          {"source"=>297, "target"=>287, "type"=>"KNOWS"},
          {"source"=>340, "target"=>287, "type"=>"ENDORSEMENT_SOURCE"},
          {"source"=>340, "target"=>324, "type"=>"ENDORSE_TOPIC"},
          {"source"=>293, "target"=>314, "type"=>"KNOWS"},
          {"source"=>297, "target"=>314, "type"=>"KNOWS"},
          {"source"=>288, "target"=>297, "type"=>"KNOWS"},
          {"source"=>333, "target"=>288, "type"=>"ENDORSEMENT_SOURCE"},
          {"source"=>333, "target"=>324, "type"=>"ENDORSE_TOPIC"}
        ]
      }
    end
  end 


end
