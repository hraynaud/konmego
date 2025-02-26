module Manager # rubocop:disable Metrics/ModuleLength
  SAMPLE_DATA_ROOT_DIR = "#{Rails.root}/etc/sample_data".freeze
  MAX_ENDORSEMENTS = 5

  class << self
    def create_users
      file_data = read_file('users_gpt.json')
      user_data = JSON.parse(file_data)
      user_data.each_with_index do |u, idx|
        create_user(u, idx)
      end
    end

    def create_user(user, idx) # rubocop:disable Metrics/MethodLength
      p = Person.new(
        first_name: user['firstName'],
        last_name: user['lastName'],
        email: "foo#{idx}@mail.com",
        password: 'konmego.far',
        bio: user['bio'],
        pursuits: user['pursuits'],
        profile_image_url: user['picture']['large'],
        avatar_url: user['picture']['thumbnail']
      )
      p.save
    end

    def create_projects
      raise 'Create sample users before assigning projects' if Person.count.zero?

      file_data = read_file('projects_gpt.json')
      project_data = JSON.parse(file_data)
      project_data.each do |p|
        create_project(p)
      end
    end

    def create_project(project) # rubocop:disable Metrics/MethodLength
      p = Project.new(
        name: project['name'],
        description: project['description'],
        start_date: project['startDate'],
        visibility: rand(4),
        deadline: project['deadline'],
        icon: project['icon'],
        progress: project['progress'],
        open_items: project['openItems'],
        roadblocks: project['roadblocks']
      )
      p.owner = random_user
      p.topic = random_global_topic
      p.save
    end

    def create_endorsements # rubocop:disable Metrics/MethodLength
      raise 'Create sample users before assigning projects' if Person.count.zero?

      data = read_file('endorsements_gpt.json')
      @praises = JSON.parse(data)

      Person.all.each do |person|
        endorsements_to_create = rand(MAX_ENDORSEMENTS)
        while endorsements_to_create.positive?
          topic_name = random_user_pursuit(person)
          begin
            create_endorsement(person, topic_name)
            endorsements_to_create -= 1
          rescue StandardError
            Rails.logger.warn('duplicate endorsment')
          end

        end
      end
    end

    def create_endorsement(endorsee, topic_name)
      endorser = random_user
      content = random_endorsement_by(topic_name)
      topic = TopicService.find_or_create_by_name({ name: topic_name })
      params = { endorsee_id: endorsee.id, topic_id: topic.id,
                 description: content.gsub('<<person>>', endorsee.first_name) }

      endorsement = EndorsementService.create(endorser, params)
      EndorsementService.accept(endorsement, endorsee)
    rescue ActiveGraph::Node::Persistence::RecordInvalidError
      # no op
    end

    def random_endorsement_by(topic_name)
      if @praises.key? topic_name
        num_items = @praises[topic_name].count
        rnd_idx = rand(num_items)
        @praises[topic_name][rnd_idx]
      else
        "<<person>> is a boss when it comes to #{topic_name}"
      end
    end

    def create_topics # rubocop:disable Metrics/MethodLength
      data = File.read("#{SAMPLE_DATA_ROOT_DIR}/category_topics_gpt.json")
      category_topics = JSON.parse(data)

      category_topics.each do |category|
        cat_name = category['category']
        category['topics'].each do |topic|
          topic_name = topic['topic']
          icon_name = topic['icon']
          params = { name: topic_name, category: cat_name, icon: icon_name }
          TopicService.find_or_create_by_name(params)
        end
      end
    end

    def create_relationships(from, to, topic, description); end

    def to_params(endorsee, topic)
      { endorsee_id: endorsee.id, topic_id: topic.id, description: }
    end

    def read_file(file_name)
      File.read("#{SAMPLE_DATA_ROOT_DIR}/#{file_name}")
    end

    def random_user
      @users ||= Person.all
      @users[rand(@users.count)]
    end

    def random_user_pursuit(user)
      topics = user['pursuits'].map { |p| p['topic'] }
      if topics.empty?
        topic = random_global_topic
        topic.name
      else
        topics[rand(topics.count)]
      end
    end

    def random_global_topic
      @topics ||= Topic.all
      @topics[rand(@topics.count)]
    end

    def group_content(flowers)
      by_topic = {}
      flowers.each do |f|
        topic = f['topic']
        content = f['content']

        by_topic[topic] = [] if by_topic[topic].nil?

        by_topic[topic] << content
      end
      by_topic
    end
  end

  module Clean
    class << self
      def all
        topics
        users
        endorsements
        identities
        projects
      end

      def topics
        ActiveGraph::Base.query('MATCH (n:Topic) DETACH DELETE n')
      end

      def users
        ActiveGraph::Base.query('MATCH (n:Person) DETACH DELETE n')
      end

      def endorsements
        ActiveGraph::Base.query('MATCH (n:Endorsement) DETACH DELETE n')
      end

      def friendships
        ActiveGraph::Base.query('MATCH (p1:Person)-[r:KNOWS]-(p2:Person) DELETE r')
      end

      def identities
        ActiveGraph::Base.query('MATCH (n:Identity) DETACH DELETE n')
      end

      def projects
        ActiveGraph::Base.query('MATCH (n:Project) DETACH DELETE n')
      end
    end
  end
end
