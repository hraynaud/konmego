class ProjectSearchService

  def self.find_by_topic topic_name
    base.topic.where(name: topic_name).pluck(:projects)
  end

  def self.find_by_topic_and_visibility topic_name, visibility = :friends
    with_visibility(visibility).topic.where(name: topic_name).pluck(:projects)
  end

  def self.with_visibility visibility
    base.where(visibility: visibility)
  end

  def self.base
    Project.all.as(:projects)
  end

  def self.find_friend_projects person
    person.contacts.projects
  end

end
