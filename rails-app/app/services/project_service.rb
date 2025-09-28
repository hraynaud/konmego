require 'securerandom'

class ProjectService
  class << self
    def create(owner, params)
      Project.new(params).tap do |project|
        project.owner = owner
        build_embeddings(project)
        project.save!
      end
    end

    def update(user, project_id, params)
      project = user.projects.find_by(id: project_id)
      project.update(params)
      build_embeddings(project) if project.name.changed? || project.description.changed?
      project.save!
    end

    def find_by_id(id)
      Project.find(id)
    end

    def find_by_uuid(uuid)
      Project.where(uuid: uuid).first
    end

    def with_associations(uuid)
      Project.where(uuid: uuid).with_associations(:owner, :participants, :promoters).first
    rescue ActiveGraph::Node::Labels::RecordNotFound
      raise StandardError, 'Project not found'
    end

    def build_embeddings(project)
      optimized = optimize_for_embedding(project)
      project.embeddings = AiService.embedding(optimized)
      project.save
      project
    end

    def optimize_for_embedding(project)
      "#{project.description}\n#{project.name}"
    end

    def add_obstacle(obstacle); end

    def add_participant; end

    def add_topics; end
  end
end
