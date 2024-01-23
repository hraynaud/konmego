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
        deadline: project['deadline'],
        icon: project['icon'],
        progress: project['progress'],
        open_items: project['openItems'],
        roadblocks: project['roadblocks']
      )
      p.owner = random_user
      p
    end

    def create_endorsements # rubocop:disable Metrics/MethodLength
      raise 'Create sample users before assigning projects' if Person.count.zero?

      data = read_file('endorsements_gpt.json')
      @praises = JSON.parse(data)


      Person.all.each do |person|
        endorsements_to_create = rand(MAX_ENDORSEMENTS)
        while endorsements_to_create.positive?
          topic_name = random_user_pursuit(person)
          create_endorsement(person, topic_name)
          endorsements_to_create -= 1
        end
      end
    end

    def create_endorsement(endorsee, topic_name)
      endorser = random_user
      content = random_endorsement_by(topic_name)
      topic = TopicService.find_by_name(topic_name)
      create_relations(endorser, endorsee, topic, content)
    rescue ActiveGraph::Node::Persistence::RecordInvalidError
      # no op
    end

    def random_endorsement_by(topic_name)
      if @praises.key? topic
        rnd_idx = rand(praises[topic].count)
        @praises[topic][rnd_idx]
      else
        "{{person}} is a boss when it comes to #{topic}"
      end
    end

    def create_topics
      data = File.read("#{SAMPLE_DATA_ROOT_DIR}/category_topics_gpt.json")
      category_topics = JSON.parse(data)
      category_topics.each do |cat|
        cat['topics'].each do |topic|
          TopicService.find_or_create_by_name({ name: topic['topic'], category: cat['category'], icon: topic['icon'] })
        end
      end
    end

    def create_relations(from, to, topic, description)
      EndorsementService.create(from, { endorsee_id: to.id, topic_id: topic.id, description: description })
      RelationshipManager.befriend from, to
    end

    def to_params(endorsee, topic)
      { endorsee_id: endorsee.id, topic_id: topic.id, description: description }
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
      topics[rand(topics.count)]
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
        endorsments
        identities
        projects
      end

      def topics
        ActiveGraph::Base.query('MATCH (n:Topic) DETACH DELETE n')
      end

      def users
        ActiveGraph::Base.query('MATCH (n:Person) DETACH DELETE n')
      end

      def endorsments
        ActiveGraph::Base.query('MATCH (n:Endorsement) DETACH DELETE n')
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
