
module TestDataHelper

  module Relationships

    def setup_relationship_data
      create_social_graph
      create_endorsements
      set_endorsement_statuses
    end

    def create_social_graph
      create_users
      create_topics
      create_friendships
    end

    def create_users
      @herby, @tisha, @franky, @fauzi, @kendra, @sar, @elsa, @vince, @jean, @nuno, @gilbert, @jerry= %w(
      herby tisha franky fauzi kendra sar elsa vince jean nuno gilbert jerry
      ).map do |fname|
        FactoryBot.create(:person, identity: FactoryBot.create(:identity, first_name: fname.titleize, last_name: "Skillz"))
      end

      @hidden = FactoryBot.build(:person,identity: FactoryBot.create(:identity, first_name: "Hidden", last_name: "Hidden"))
    end

    def create_topics
      @cooking, @fencing, @acting, @djing, @singing, @design, @composer, @software, @beatmaking = %w(
      cooking fencing acting djing singing design composer software beatmaking
      ).map do |skill|
        FactoryBot.create(:topic, name: skill.titleize )
      end
    end

    def create_friendships
      RelationshipManager.befriend @herby, @tisha
      RelationshipManager.befriend @herby,  @franky 
      RelationshipManager.befriend @franky,  @sar
      RelationshipManager.befriend @kendra, @vince
      RelationshipManager.befriend @sar, @elsa
      RelationshipManager.befriend @gilbert, @nuno
      RelationshipManager.befriend @gilbert, @jean
    end

    def create_endorsements
      @accepted = []
      @pending = []
      @declined = []

      @accepted << EndorsementService.create(@fauzi, to_params(@franky, @cooking))#fauzi [KNOWS] franky
      @accepted << EndorsementService.create(@tisha, to_params( @vince, @composer)) #tisha  [KNOWS] kendra
      @accepted << EndorsementService.create(@tisha, to_params(@kendra, @singing)) #tisha  [KNOWS] kendra
      @accepted << EndorsementService.create(@jean, to_params(@sar, @djing)) 
      @accepted << EndorsementService.create(@sar, to_params(@jerry, @djing)) 
      @accepted << EndorsementService.create(@nuno, to_params(@sar, @djing))

     # DECLINED OR PENDING
     # -----------------------

      @declined << EndorsementService.create(@jean, to_params(@vince, @composer))
      @pending << EndorsementService.create(@elsa, to_params(@sar, @acting))

    end

    def to_params(endorsee, topic)
      {endorsee_id: endorsee.id, topic_id: topic.id} 
    end

    def set_endorsement_statuses
      @accepted.each do |e|
        EndorsementService.accept(e)
      end

      @declined.each do |e|
        EndorsementService.decline(e)
      end
    end

    def extract_names items
      items.map(&:name).to_set
    end

    def empty_set
      [].to_set
    end
    
    def hidden_resource
    end

  end

  module Utils
    def clear_db
      ActiveGraph::Base.query('MATCH (n) WHERE NOT n:`ActiveGraph::Migrations::SchemaMigration` DETACH DELETE n')
    end
  end

  module Projects


    def setup_projects
      # elsa
      @chef_project = FactoryBot.create(:project, :valid, name: "Chef", topics: [@cooking], owner: @elsa, visibility: :friends)
      
      # fauzi
      @dining_project = FactoryBot.create(:project, :valid, name: "Dining", topics: [@cooking], owner: @fauzi, visibility: :friends)

      #franky
      @dj_project = FactoryBot.create(:project, :valid, name: "DJ", topics: [@djing], owner: @franky, visibility: :friends)
      @culinary_project = FactoryBot.create(:project, :valid, name: "Culinary", topics: [@cooking], owner: @franky, visibility: :friends)
      @software_project = FactoryBot.create(:project, :valid, name: "Software", topics: [@software], owner: @franky, visibility: :private)

      # jean
      @app_project = FactoryBot.create(:project, :valid, name: "App", topics: [@software], owner: @jean, visibility: :friends)
      @vocalist_project = FactoryBot.create(:project, :valid, name: "Vocalist", topics: [@singing], owner: @jean) #private

      # sar
      @acting_project = FactoryBot.create(:project, :valid, name: "Acting", topics: [@acting], owner: @sar, visibility: :friends)

      # NO OWNERS
      @fencing_project = FactoryBot.create(:project, :valid, name: "Fencing", topics: [@fencing])
      @vocalist2_project = FactoryBot.create(:project, :valid, name: "Vocalist 2", topics: @singing, visibility: :public)

      #TODO Add new in_network project
      #@producer_project = FactoryBot.create(:project, :valid, name: "Make beats", topics: @beatmaking, owner: @fauzi, visibility: :in_network)
    end
  end


  module SampleResults

    def sars_cooking_network 
      {
        "nodes"=> [
          {"label"=>"Sar Skillz", "type"=>"Person", "id"=>293},
          {"label"=>"Fauzi Skillz", "type"=>"Person", "id"=>288},
          {"label"=>"Franky Skillz", "type"=>"Person", "id"=>243},
          {"label"=>"Cooking", "type"=>"Topic", "id"=>324},
          {"label"=>"Fauzi Skillz Endorses someone for Cooking", "type"=>"Endorsement", "id"=>333}
        ],

        "links"=> [
          {"source"=>297, "target"=>287, "type"=>"KNOWS"},
          {"source"=>340, "target"=>287, "type"=>"ENDORSEMENT_SOURCE"},
          {"source"=>340, "target"=>324, "type"=>"ENDORSE_TOPIC"},
          {"source"=>288, "target"=>297, "type"=>"KNOWS"},
          {"source"=>333, "target"=>288, "type"=>"ENDORSEMENT_SOURCE"},
          {"source"=>333, "target"=>324, "type"=>"ENDORSE_TOPIC"}
        ]
      }
    end
  end 


#
  # vince    --> tisha --> kendra
  #                    \
  #                      herby  --> franky 
  #                           : --> fauzi
  #                           : --> elsa
  #                                      \__ --> sar
  #                                      /
  #                           : --> jean
  #
  #
  # tisha --> herby  : --> franky
  #                  : --> elsa
  #                  : --> jean
  #
  #
  #
  #
  # herby -->  : --> franky 
  #            : --> fauzi
  #            : --> elsa  ---\
  #                            --> sar
  #            : --> jean  ---/     /
  #                           \ --> vince
  #            : --> tisha ---/
  #
  #            : --> tisha  --> Kendra
  #            :
  #
  #
  #
  #
  #
  #
  #


end
