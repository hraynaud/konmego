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

    def create_users # rubocop:disable Metrics/AbcSize
      @herby, @tisha, @franky, @fauzi, @kendra, @sar, @elsa, @vince, @jean, @nuno, @gilbert, @jerry, @rico, @wid, @stan = %w[
        herby tisha franky fauzi kendra sar elsa vince jean nuno gilbert jerry rico wid stan
      ].map do |fname|
        FactoryBot.create(:member, first_name: fname.titleize, last_name: 'Skillz')
      end

      @hidden = FactoryBot.build(:person, first_name: 'Hidden', last_name: 'Hidden')
    end

    def create_topics
      @cooking, @fencing, @acting, @djing, @singing, @design,
      @composer, @software, @beatmaking, @basketball, @electrical, @portugal = [
        'cooking', 'fencing', 'acting', 'djing', 'singing', 'design', 'composer', 'software', 'Beat making', 'basketball', 'electrical', 'portugal'
      ].map do |skill|
        FactoryBot.create(:topic, name: skill.titleize, like_terms: skill, default_image_file: "#{skill}.jpeg")
      end
    end

    def create_friendships
      # TODO: create some sample friendships that don't break test
      # RelationshipManager.befriend @herby, @tisha
    end

    def create_endorsements
      @accepted = []
      @pending = []
      @declined = []
      create_endorsement(@fauzi, @franky, @cooking)
      create_endorsement(@tisha, @nuno, @design)
      create_endorsement(@tisha, @vince, @composer)
      create_endorsement(@nuno, @franky, @beatmaking)
      create_endorsement(@rico, @wid, @beatmaking)

      create_endorsement(@franky, @fauzi, @djing)
      create_endorsement(@sar, @herby, @djing)
      create_endorsement(@nuno, @wid, @software)
      create_endorsement(@elsa, @herby, @software)
      create_endorsement(@kendra, @sar, @acting)
      create_endorsement(@vince, @jean, @fencing)
      create_endorsement(@gilbert, @elsa, @design)

      create_endorsement(@stan, @nuno, @portugal)

      create_endorsement(@elsa, @stan, @basketball)
      create_endorsement(@elsa, @sar, @acting,
                         'Sars performance in his last movie was incredible. He really became the character')

      # DECLINED OR PENDING
      # -----------------------

      # @declined << EndorsementService.create(@jean, to_params(@vince, @composer))
      # # @pending << EndorsementService.create(@elsa, to_params(@sar, @acting))
      # @pending << EndorsementService.create(@stan, to_params(@wid, @electrical))
    end

    def create_endorsement(from, to, topic, description = nil)
      endorsement = EndorsementService.create(from, to_params(to, topic, description))
      @accepted << EndorsementService.accept(endorsement, to)
      RelationshipManager.befriend from, to
      endorsement
    end

    def to_params(endorsee, topic, description)
      { endorsee_id: endorsee.id, topic_id: topic.id, description: description || topic.name }
    end

    def set_endorsement_statuses
      @accepted.each do |e|
        EndorsementService.accept(e)
      end

      @declined.each do |e|
        EndorsementService.decline(e)
      end
    end

    def extract_names(items)
      items.to_set(&:name)
    end

    def empty_set
      [].to_set
    end

    def hidden_resource; end
  end

  module Projects
    def setup_projects # rubocop:disable Metrics/MethodLength
      # elsa
      @chef_project_friends = FactoryBot.create(:project, :valid, name: 'Chef', topic: @cooking, owner: @elsa,
                                                                  visibility: :friends)

      # fauzi
      @dining_project_friends = FactoryBot.create(:project, :valid, name: 'Dining', topic: @cooking, owner: @fauzi,
                                                                    visibility: :friends)

      # franky
      @dj_project_friends = FactoryBot.create(:project, :valid, name: 'DJ', topic: @djing, owner: @franky,
                                                                visibility: :friends)
      @culinary_project_friends = FactoryBot.create(:project, :valid, name: 'Culinary', topic: @cooking, owner: @franky,
                                                                      visibility: :friends)
      @software_project_private = FactoryBot.create(:project, :valid, name: 'Software', topic: @software, owner: @franky,
                                                                      visibility: :private)

      # jean
      @app_project_friends = FactoryBot.create(:project, :valid, name: 'App', topic: @software, owner: @jean,
                                                                 visibility: :friends)
      @singing_project_private = FactoryBot.create(:project, :valid, name: 'Vocalist', topic: @singing, owner: @jean) # private default

      # sar
      @acting_project_friends = FactoryBot.create(:project, :valid, name: 'Acting', topic: @acting, owner: @sar,
                                                                    visibility: :friends)

      # NO OWNERS
      @fencing_project_private = FactoryBot.create(:project, :valid, name: 'Fencing', topic: @fencing)
      @singing_project2_public = FactoryBot.create(:project, :valid, name: 'Vocalist 2', topic: @singing,
                                                                     visibility: :public)

      # TODO: Add new in_network project
      # @producer_project = FactoryBot.create(:project, :valid, name: "Make beats", topic: @beatmaking, owner: @fauzi, visibility: :in_network)
    end
  end

  module SampleResults
  end

  module Utils
    def to_embed_txt(topic)
      "#{topic} \n #{topic}"
    end

    def clear_db
      ActiveGraph::Base.query('MATCH (n) WHERE NOT n:`ActiveGraph::Migrations::SchemaMigration` DETACH DELETE n')
    end

    def mock_like_terms(topic)
      allow(TopicService).to receive(:generate_like_terms).with(any_args).and_return(topic)
    end
  end
end
