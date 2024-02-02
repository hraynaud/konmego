class ProjectSearchService
  DEFAULT_PROJECT_SEARCH_DEPTH = 1
  PUBLIC_VIZ = Project.visibilities[:public]
  CYPHER_ANY = '.*'.freeze

  class << self
    def search(params)
      process_params params
      results = exec_project_query
      results.pluck(:projects)
    end

    def random(limit = 3, visibility = PUBLIC_VIZ)
      results = ActiveGraph::Base.query("MATCH (p:Project)
        WHERE p.visibility <= $visibility
        WITH p, rand() AS r
        ORDER BY r
        RETURN p as projects
        LIMIT $limit", limit: limit, visibility: visibility)
      results.pluck(:projects)
    end

    private

    def process_params(params)
      @visibility = params[:visibility] || PUBLIC_VIZ
      @user_scope = define_user_scope @visibility
      @topic = params[:topic] || CYPHER_ANY
      @depth = hop_range params[:hops]
      @friend_id = params[:friend_id] || CYPHER_ANY
      @viz_comparison = public? ? "= #{PUBLIC_VIZ}" : "<= #{@visibility}"
    end

    def define_user_scope(visibility)
      if visibility < PUBLIC_VIZ
        current_user.uuid
      else
        CYPHER_ANY
      end
    end

    def hop_range(hops)
      depth = hops || 2
      public? ? '' : "*1..#{depth}"
    end

    def public?
      @visibility == PUBLIC_VIZ
    end

    def by_topic(scope, topic_id)
      scope = scope.topic.where(id: topic_id) if topic_id
      scope
    end

    def exec_project_query
      ActiveGraph::Base.query(
        "MATCH (starter:Person)-[:`KNOWS`#{@depth}]-(friend:Person)
        -[:OWNS]->(project:Project)
        WHERE starter.uuid =~ $uuid
        AND project.visibility #{@viz_comparison}
        AND friend.uuid =~ $friend_id
        RETURN DISTINCT project as projects
      ", topic: @topic, uuid: @user_scope, friend_id: @friend_id
      )
    end
  end
end
