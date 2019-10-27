module TopicCreationService

  class << self

    def create params
      Topic.create(name: normalize(params[:name]))
    end

    def find_related_or_synonym name
      #TODO implement
      [] 
    end

    private

    def normalize name
      #TODO implement 
      name
    end
  end
end
