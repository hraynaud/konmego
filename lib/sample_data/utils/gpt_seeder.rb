module GptSeeder
  SAMPLE_DATA_ROOT_DIR = "#{Rails.root}/etc/sample_data".freeze
  class << self
    def seed_projects
      data = File.open("#{SAMPLE_DATA_ROOT_DIR}/topics_gpt.txt").read
      projects = []
      # @used_topics = {}

      @topic_list = data.split("\n")

      # @topic_list.each { |topic| @used_topics[topic] = 0 }

      asst = OpenAiAssistant::ProjectGenerator.new

      20.times do
        topic = random_topic
        puts "generating gpt project for #{topic}"
        projects << asst.generate(topic)
      end

      File.open("#{SAMPLE_DATA_ROOT_DIR}/projects_gpt.json", 'w') { |f| f.write JSON.generate(projects) }
    end

    def seed_endorsements # rubocop:disable Metrics/MethodLength
      data = File.open("#{SAMPLE_DATA_ROOT_DIR}/topics_gpt.txt").read
      endorsements = []
      # @used_topics = {}

      @topic_list = data.split("\n")

      # @topic_list.each { |topic| @used_topics[topic] = 0 }

      asst = OpenAiAssistant::EndorsementGenerator.new

      50.times do
        topic = random_topic
        next if topic.nil?

        puts "generating endorsement for #{topic}"
        endorsements << asst.generate(topic)
      end

      File.open("#{SAMPLE_DATA_ROOT_DIR}/endorsements_gpt.json", 'w') { |f| f.write JSON.generate(endorsements) }
    end

    def random_topic
      @topic_list[rand(@topic_list.count + 1)]
    end
  end
end
