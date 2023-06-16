module TopicService

  class << self

    def get id
      Topic.where(id: id).first
    end

    def find_by_name name
      Topic.where(name: name).first
    end

    def find_related_or_synonym name
      #TODO implement
      [] 
    end

    def find_or_create_by_name params
        find_by_name(params[:name]) or
        Topic.create(name: params[:name], category: params[:category])
    end

  end

end

