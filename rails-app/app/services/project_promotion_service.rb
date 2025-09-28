class ProjectPromotionService
  def self.promote(user, project)
    return false if user.promoted_projects.include?(project) || project.owner == user

    user.promoted_projects << project
    project
  rescue Neo4j::ActiveNode::Persistence::RecordInvalid => _e
    false
  end

  def self.demote(user, project)
    return unless user.promoted_projects.where(id: project.id).exists?

    user.promoted_projects.delete(project)
    true
  end
end
