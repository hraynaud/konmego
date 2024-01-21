module GptSeeder
  SAMPLE_DATA_ROOT_DIR = "#{Rails.root}/etc/sample_data".freeze

  def self.seed_projects # rubocop:disable Metrics/MethodLength
    data = File.open("#{SAMPLE_DATA_ROOT_DIR}/topics_gpt.txt").read
    projects = []
    @used_topics = {}

    @topic_list = data.split("\n")

    @topic_list.each { |topic| @used_topics[topic] = 0 }

    asst = OpenAiAssistant::ProjectGenerator.new

    20.times do
      topic = random_topic
      puts "generating gpt project for #{topic}"
      projects << asst.generate(topic)
    end

    File.open("#{SAMPLE_DATA_ROOT_DIR}/projects_gpt.json", 'w') { |f| f.write JSON.generate(projects) }
  end
end
