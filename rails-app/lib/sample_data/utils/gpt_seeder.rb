module GptSeeder
  SAMPLE_DATA_ROOT_DIR = "#{Rails.root}/etc/sample_data".freeze
  class << self
    def seed_projects(num = 20) # rubocop:disable Metrics/MethodLength
      @topic_list = Topic.all
      raise 'Empty topic list no projects created' if @topic_list.empty?

      projects = []
      asst = OpenAiAssistant::ProjectGenerator.new

      num.times do
        topic = @topic_list[rand(@topic_list.count)]
        name = topic.name
        puts "generating gpt project for #{name}"
        projects << asst.generate(name)
      end

      File.write("#{SAMPLE_DATA_ROOT_DIR}/tmp/projects_gpt_#{Time.now.to_i}.json", JSON.generate(projects))
    end

    def seed_endorsements
      asst = OpenAiAssistant::EndorsementGenerator.new
      data = File.read("#{SAMPLE_DATA_ROOT_DIR}/topics_gpt.json")

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
