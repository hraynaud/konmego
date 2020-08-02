class ProjectSearchService

  DEFAULT_PROJECT_SEARCH_DEPTH = 1
  class << self

    def search user, params = {}
      scope = initial_scope user, params
      scope = by_topic(scope, params[:topic])
      scope.pluck(:projects)
    end

    private

    def initial_scope user, params
      friend = are_first_friends? user, params[:friend]
      friend ? projects_for(friend) : projects_for(all_contacts(user,params[:depth] || DEFAULT_PROJECT_SEARCH_DEPTH))
    end

    def are_first_friends? user, friend
      user.friends_with?(friend) ? friend : nil
    end

    def all_contacts person, depth 
      person.contacts(:contacts, :r, rel_length: 0..depth).distinct
    end

    def projects_for scope
      scope.projects(:projects).where("projects.visibility > ? ", Project.visibilities[:private]).distinct 
    end

    def by_topic scope, topic_id
      if topic_id
        scope = scope.topic.where(id: topic_id)
      end
      scope
    end

  end
end
