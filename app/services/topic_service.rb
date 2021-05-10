module TopicService

  class << self

    def get params
      Topic.where(id: params[:topic_id]).first or 
        Topic.where(name: params[:name]).first or
        Topic.create(name: params[:name], category: params[:category])

    end

    def find_related_or_synonym name
      #TODO implement
      [] 
    end

  end

end

