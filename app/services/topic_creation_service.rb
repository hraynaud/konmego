module TopicCreationService

  class << self

    def create params
      Topic.create(name: normalize_name(params))
    end

    def find_related_or_synonym name
      #TODO implement
      [] 
    end

    private

    def normalize_name params
      return params.dig(:name) if params
    end
  end
end
