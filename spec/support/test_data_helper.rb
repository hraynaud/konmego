
module TestDataHelper

  module Relationships

    def setup_relationship_data
      create_social_graph
      create_endorsements
      # set_endorsement_statuses
    end

    def create_social_graph
      create_users
      create_topics
      create_friendships
    end

    def create_users
      @herby, @tisha, @franky, @fauzi, @kendra, @sar, @elsa, @vince, @jean, @nuno, @gilbert, @jerry, @rico, @wid, @stan = %w(
      herby tisha franky fauzi kendra sar elsa vince jean nuno gilbert jerry rico wid stan
      ).map do |fname|
        FactoryBot.create(:member,  first_name: fname.titleize, last_name: "Skillz")
      end

      @hidden = FactoryBot.build(:person,identity: FactoryBot.create(:identity, first_name: "Hidden", last_name: "Hidden"))
    end

    def create_topics
      @cooking, @fencing, @acting, @djing, @singing, @design, @composer, @software, @beatmaking, @basketball, @electrical, @portugal= %w(
      cooking fencing acting djing singing design composer software beatmaking basketball electrical portugal
      ).map do |skill|
        FactoryBot.create(:topic, name: skill.titleize, default_image_file: "#{skill}.jpeg")
      end
    end

    def create_friendships
      # RelationshipManager.befriend @herby, @tisha
      # RelationshipManager.befriend @herby,  @franky 
      # RelationshipManager.befriend @franky,  @sar
      # RelationshipManager.befriend @kendra, @vince
      # RelationshipManager.befriend @kendra, @sar
      # RelationshipManager.befriend @sar, @elsa
      # RelationshipManager.befriend @gilbert, @nuno
      # RelationshipManager.befriend @gilbert, @jean
      # RelationshipManager.befriend @herby, @rico
      # RelationshipManager.befriend @rico, @wid
      # RelationshipManager.befriend @wid, @stan
    end

    def create_endorsements
      @accepted = []
      @pending = []
      @declined = []

      do_accept(@fauzi, @franky, @cooking)
      do_accept(@franky, @fauzi, @djing)
      do_accept(@sar, @herby, @djing)
      do_accept(@tisha,  @vince, @composer)
      do_accept(@nuno, @wid, @software)
      do_accept(@elsa, @herby, @software)
      do_accept(@kendra, @sar, @acting)
      do_accept(@vince, @jean, @fencing)
      do_accept(@gilbert, @elsa, @design)
      do_accept(@tisha, @nuno, @design)   
      do_accept(@rico, @wid, @beatmaking)
      do_accept(@stan, @nuno, @portugal)
      do_accept(@nuno, @franky, @beatmaking)
      do_accept(@elsa, @stan, @basketball)

    

     # DECLINED OR PENDING
     # -----------------------

      @declined << EndorsementService.create(@jean, to_params(@vince, @composer))
      @pending << EndorsementService.create(@elsa, to_params(@sar, @acting))

    end

    def do_accept(from, to, topic)
      @accepted << EndorsementService.create(from, to_params(to, topic))
      RelationshipManager.befriend from, to
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


  module Projects


    def setup_projects
      # elsa
      @chef_project = FactoryBot.create(:project, :valid, name: "Chef", topic: @cooking, owner: @elsa, visibility: :friends)
      
      # fauzi
      @dining_project = FactoryBot.create(:project, :valid, name: "Dining", topic: @cooking, owner: @fauzi, visibility: :friends)

      #franky
      @dj_project = FactoryBot.create(:project, :valid, name: "DJ", topic: @djing, owner: @franky, visibility: :friends)
      @culinary_project = FactoryBot.create(:project, :valid, name: "Culinary", topic: @cooking, owner: @franky, visibility: :friends)
      @software_project = FactoryBot.create(:project, :valid, name: "Software", topic: @software, owner: @franky, visibility: :private)

      # jean
      @app_project = FactoryBot.create(:project, :valid, name: "App", topic: @software, owner: @jean, visibility: :friends)
      @vocalist_project = FactoryBot.create(:project, :valid, name: "Vocalist", topic: @singing, owner: @jean) #private

      # sar
      @acting_project = FactoryBot.create(:project, :valid, name: "Acting", topic: @acting, owner: @sar, visibility: :friends)

      # NO OWNERS
      @fencing_project = FactoryBot.create(:project, :valid, name: "Fencing", topic: @fencing)
      @vocalist2_project = FactoryBot.create(:project, :valid, name: "Vocalist 2", topic: @singing, visibility: :public)

      #TODO Add new in_network project
      #@producer_project = FactoryBot.create(:project, :valid, name: "Make beats", topic: @beatmaking, owner: @fauzi, visibility: :in_network)
    end
  end


  module SampleResults

 
  end 

  module Utils
    def clear_db
      ActiveGraph::Base.query('MATCH (n) WHERE NOT n:`ActiveGraph::Migrations::SchemaMigration` DETACH DELETE n')
    end
  end






end
