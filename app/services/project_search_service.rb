class ProjectSearchService

  DEFAULT_PROJECT_SEARCH_DEPTH = 1
  class << self

    def search user, params = {}
      scope = initial_scope user, params
      scope = by_topic(scope, params[:topic])
      scope.pluck(:projects)
    end

    private

    def friends
      user.contacts
    end

    def resolve_topic(topic_id)
      topic_id ? Topic.find(topic_id) : nil
    end

    def resolve_friend(friend_id)
      friend_id ? Person.find(friend_id) : nil
    end

    def initial_scope user, params
      
      depth = params[:depth] || DEFAULT_PROJECT_SEARCH_DEPTH
      friend = are_first_friends? user, resolve_friend(params[:friend])
      friend ? projects_for(friend) : projects_for(user.contacts_by_depth(depth))
    end

    def are_first_friends? user, friend
      user.friends_with?(friend) ? friend : nil
    end

    def projects_for scope
      scope.projects(:projects).public.distinct 
    end

    def by_topic scope, topic_id
      if topic_id
        scope = scope.topic.where(id: topic_id)
      end
      scope
    end

  end
end
