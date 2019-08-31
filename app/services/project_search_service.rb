class ProjectSearchService

  def self.all_by_topic topic_name
    all_scope.topic.where(name: topic_name).pluck(:projects)
  end

  def self.find_by_topic_and_visibility topic_name, min_visibility = :friends
    by_visibility(all_scope, min_visibility).topic.where(name: topic_name).pluck(:projects)
  end

  def self.by_topic project_scope, topic_name
    project_scope.topic.where(name: topic_name).pluck(:projects)
  end

  def self.find_friend_projects person, min_visibility = :friends
    by_visibility(friend_scope(person), min_visibility)
  end

  def self.by_visibility project_scope, min_visibility = :public
    if min_visibility == :private
      project_scope.where("false") # Will always return empty set
    else
      project_scope.where("projects.visibility >= ? ", Project.visibilities[min_visibility])
    end
  end

  def self.friend_scope person
    person.contacts.projects.as(:projects)
  end

  def self.all_scope
    Project.all.as(:projects)
  end
end
