class ProjectSearchService
  def self.search params = {}
    scope =initial_scope params
    visibility = params[:min_visibility]
    topic_name = params[:topic]

    if visibility.present?
      scope = scope.where("projects.visibility >= ? ", Project.visibilities[visibility])
    end

    if topic_name.present?
      scope = scope.topic(:t).where("t.name = ?", topic_name) #.pluck(:projects)
    end

    scope.pluck(:projects)
  end

  def self.initial_scope params
    if params[:person].present? 
      params[:depth] && params[:depth] > 0 ? contacts_scope(params[:person], params[:depth]) : current_user_scope(params[:person]) 
    else
      empty_scope
    end
  end

  def self.all_by_topic topic_name
    by_topic(all_scope, topic_name).pluck(:projects)
  end

  def self.all_by_topic_and_visibility topic_name, min_visibility = :friends
    by_visibility(all_scope, min_visibility).topic.where(name: topic_name)
      .pluck(:projects)
  end

  def self.find_friend_projects person
    by_visibility(friend_scope(person), :friends)
  end

  def self.find_friend_projects_by_topic person, topic_name
    by_visibility(by_topic(friend_scope(person), topic_name), :friends)
      .pluck(:projects)
  end


  def self.find_all_contact_projects_by_topic person,topic, depth = 3
    by_topic(find_all_contact_projects(person,  depth), topic)
      .pluck(:projects)
  end

  def self.find_all_contact_projects person, depth = 3
    person
      .contacts(:contacts, :r, rel_length: 0..depth).distinct
      .projects(:projects).where("projects.visibility > ? ", Project.visibilities[:private]).distinct 
  end

  def self.by_topic project_scope, topic_name
    project_scope.topic.where(name: topic_name)
  end

  #TODO FIXME
  def self.find_all_contact_projects_by_topic_and_visibility person,topic_name, depth = 3
    by_visibility(find_all_contact_projects(person,  depth), :friends).topic.where(name: topic_name).pluck(:projects)
  end

  def self.by_visibility project_scope, min_visibility = :public
    if min_visibility == :private
      project_scope.where("false") # Will always return empty set
    else
      project_scope.where("projects.visibility >= ? ", Project.visibilities[min_visibility])
    end
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
