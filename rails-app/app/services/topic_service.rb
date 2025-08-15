module TopicService
  class << self
    def get(topic_id)
      Topic.where(id: topic_id).first
    end

    def find_by_name(name)
      Topic.where(name:).first
    end

    def find_or_create(params)
      return get(params[:topic_id]) if params[:topic_id]

      find_or_create_by_name(params) if params[:name]
    end

    def find_or_create_by_name(params)
      topic = find_by_name(params[:name])
      topic.nil? ? create(params) : topic
    end

    def create(params)
      topic = Topic.new(name: params[:name], icon: params[:icon])

      data = generate_like_terms(topic.name)
      topic.like_terms = data['terms']
      topic.save
      topic
    end

    def generate_like_terms(name)
      completion = AiService.completion(topic_prompt(name))
      AiService.parse_completion(completion)
    end

    def topic_prompt(name)
      prompt = %(
      You are powerful semantic search and thesaurus robot that only responds in JSON.
      Given a topic word or phrase you will generate 20 synonyms or related terms in the same category, theme or
      knowledge domain as the input topic Your response will be processed electronically so it must only include JSON.

      Here are your instructions:
      Output the data only in this exact JSON format:  {"terms":["term 1 ", "term 2", "term 3",...]}
      Do not include any commentary or follow up questions or comments in the response output.

      ### Example:
      **Input**:
      yoga

      **Output**
      {
      "terms": [
        "pilates",
        "fitness",
        "flexibility",
        "stretching",
        "Vinyasa",
        "Kundalini",
        "gyrotonics",
        "strength",
        "meditation"
        ]
        }

        Here is the topic

      ).freeze

      "#{prompt} \n ___ \n #{name}"
    end
  end
end
