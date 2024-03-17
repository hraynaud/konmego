module TopicService
  class << self
    def get(topic_id)
      Topic.where(id: topic_id).first
    end

    def find_by_name(name)
      Topic.where(name:).first
    end

    def find_related_or_synonym(_name)
      # TODO: implement
      []
    end

    def find_or_create(params)
      return get(params[:topic_id]) if params[:topic_id]

      find_or_create_by_name(params) if params[:name]
    end

    def find_or_create_by_name(params)
      topic = find_by_name(params[:name])
      if topic.nil?
        topic = Topic.new(name: params[:name], icon: params[:icon])
        topic.like_terms = generate_like_terms(topic.name)
        topic.save
      end
      topic
    end

    def generate_like_terms(name)
      completion = OllamaService.completion(topic_prompt)

      resp = completion[0]['response']
      data = JSON.parse(resp)

      terms = data['terms'].join(',')
      Rails.logger.debug "like terms: #{like_terms}"
      "#{name},#{terms}"
    end

    def topic_prompt
      %(
      Given the topic '#{name}' generate 20 synonyms or related terms in the same category or knowledge domain
      Your response will be processed electronically so it must only include JSON.

      Here are your instructions:
      Output the data only in this exact JSON format:  {"terms":["term 1 ", "term 2", "term 3",...]}
      Do not include any helpful commentary or follow up questions in the response output.

      )
    end
  end
end
