require 'securerandom'

class ProjectService

  class << self

    def create owner, params
      create_from_nodes(owner, TopicCreationService.find_or_create(params)
    end

    private

    def create_from_nodes owner, topic
      return build_project(owner, topic).tap do |project|
        project.save!
      end
    end

    def build_project owner, topic
      return Project.new(params[:project]).tap do |project|
        project.owner = owner
        project.topic = topic
      end
    end

  end

end
