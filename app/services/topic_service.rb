module TopicService

  class << self

    def get topic_id, name, category 
      begin 
        Topic.find(topic_id) 
      rescue 
        Topic.create(name: name, category: category)
      end
    end

    def find_related_or_synonym name
      #TODO implement
      [] 
    end


  end
end
