class ProjectSearchService

  DEFAULT_PROJECT_SEARCH_DEPTH = 1

  def self.search user, params = {}
    scope = initial_scope user, params
    scope = by_topic(scope, params[:topic])
    scope.pluck(:projects)
  end


  def self.initial_scope user, params
    friend = are_first_friends? user, params[:friend]

    friend ? projects_for(friend) : projects_for(all_contacts(user,params[:depth] || DEFAULT_PROJECT_SEARCH_DEPTH))
  end

  def self.are_first_friends? user, friend
    user.friends_with?(friend) ? friend : nil
  end

  def self.all_contacts person, depth 
    person
      .contacts(:contacts, :r, rel_length: 0..depth).distinct
  end

  def self.projects_for scope
    scope.projects(:projects).where("projects.visibility > ? ", Project.visibilities[:private]).distinct 
  end

  def self.by_topic scope, topic_name
    if topic_name
      scope = scope.topic.where(name: topic_name)
    end
    scope
  end

end
