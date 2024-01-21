module Manager
  SAMPLE_DATA_ROOT_DIR = "#{Rails.root}/etc/sample_data".freeze
  MAX_ENDORSEMENTS = 5

  class << self
    def create_users
      file_data = read_file('users_gpt.json')
      user_data = JSON.parse(file_data)
      user_data.each do |u, idx|
        create_user(u, idx)
      end
    end

    def create_user(user, idx)
      Person.new(
        first_name: user['firstName'],
        last_name: user['lastName'],
        email: "foo#{idx}@mail.com",
        password: 'konmego.far',
        bio: user['bio'],
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
    end

    def create_endorsements
      Person.all.each do |u|
        endorsements_to_create = rand(MAX_ENDORSEMENTS + 1)

        while endorsements_to_create.positive?
          create_endorsement(u)
          endorsements_to_create -= 1
        end
      end
    end

    def create_endorsement(user)
      do_accept(user, random_user, random_topic)
    rescue ActiveGraph::Node::Persistence::RecordInvalidError
      # no op
    end

    def do_accept(from, to, topic)
      EndorsementService.create(from, to_params(to, topic))
      RelationshipManager.befriend from, to
    end

    def read_file(file_name)
      File.read("#{SAMPLE_DATA_ROOT_DIR}/#{file_name}")
    end

    def random_user
      @users ||= Person.all
      @users[rand(@users.count + 1)]
    end

    def random_topic
      @topics ||= Topic.all
      @topics[rand(@topics.count)]
    end
  end

  module Cleaner
    class << self
      def clear_all
        clear_topics
        clear_users
        clear_endorsments
        clear_identities
        clear_projects
      end

      def clear_topics
        ActiveGraph::Base.query('MATCH (n:Topic) DETACH DELETE n')
      end

      def clear_users
        ActiveGraph::Base.query('MATCH (n:Person) DETACH DELETE n')
      end

      def clear_endorsments
        ActiveGraph::Base.query('MATCH (n:Endorsement) DETACH DELETE n')
      end

      def clear_identities
        ActiveGraph::Base.query('MATCH (n:Identity) DETACH DELETE n')
      end

      def clear_projects
        ActiveGraph::Base.query('MATCH (n:Project) DETACH DELETE n')
      end
    end
  end
end
