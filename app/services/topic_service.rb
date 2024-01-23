module TopicService
  class << self
    def get(topic_id)
      Topic.where(id: topic_id).first
    end

    def find_by_name(name)
      Topic.where(name: name).first
    end

    def find_related_or_synonym(_name)
      # TODO: implement
      []
    end

    def find_or_create_by_name(params)
      topic = find_by_name(params[:name])
      if topic.nil?
        topic = Topic.new(name: params[:name], icon: params[:icon])
      end
      topic.categories << params[:category]
      topic.save
      topic
    end
  end
end
