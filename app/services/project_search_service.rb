class ProjectSearchService


  def self.search user, params = {}
    scope = contacts_scope(user, params[:depth] || Person::DEFAULT_NETWORK_SEARCH_DEPTH)
    topic_name = params[:topic]

    if topic_name.present?
      scope = scope.topic(:t).where("t.name = ?", topic_name)
    end

    scope.pluck(:projects)
  end

  def self.contacts_scope person, depth 
    person
      .contacts(:contacts, :r, rel_length: 0..depth).distinct
      .projects(:projects).where("projects.visibility > ? ", Project.visibilities[:private]).distinct 
  end

  def self.friend_scope person
    person.contacts.projects.as(:projects)
  end
  
  def self.current_user_scope user
    user.projects.as(:projects)
  end

  def self.empty_scope
    Project.where("false").as(:projects) # Will always return empty set
  end

  def self.all_scope
    Project.all.as(:projects)
  end
end
