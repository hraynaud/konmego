require 'securerandom'

class ProjectService
  class << self
    def create(owner, params)
      Project.new(params).tap do |project|
        project.owner = owner
        project.save!
      end
    end

    def update(project, params)
      project.update(params)
      project.save!
    end

    def find_by_id(id)
      Project.find(id)
    end

    def add_obstacle(obstacle); end

    def add_participant; end

    def add_topics; end
  end
end
