module GptSeeder
  SAMPLE_DATA_ROOT_DIR = "#{Rails.root}/etc/sample_data".freeze
  class << self
    def seed_projects
      data = File.read("#{SAMPLE_DATA_ROOT_DIR}/topics_gpt.txt")
      projects = []

      @topic_list = data.split("\n")

      asst = OpenAiAssistant::ProjectGenerator.new

      20.times do
        topic =  @topic_list[rand(@topic_list.count + 1)]
        puts "generating gpt project for #{topic}"
        projects << asst.generate(topic)
      end

      File.write("#{SAMPLE_DATA_ROOT_DIR}/projects_gpt.json", JSON.generate(projects))
    end

    def seed_endorsements
      asst = OpenAiAssistant::EndorsementGenerator.new
      data = File.read("#{SAMPLE_DATA_ROOT_DIR}/topics_gpt.txt")
      endorsements = {}
      @topic_list = data.split("\n")
      @topic_list.each do |topic|
        content = asst.generate(topic)
        endorsements[topic] = content[topic]
      end

      File.write("#{SAMPLE_DATA_ROOT_DIR}/endorsements_gpt.json", JSON.generate(endorsements))
    end
  end
end
