class ProjectSearchService
  DEFAULT_PROJECT_SEARCH_DEPTH = 1
  PUBLIC_VIZ = Project.visibilities[:public]
  FRIENDS_VIZ = Project.visibilities[:friends]
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
        LIMIT $limit", limit:, visibility:)
      results.pluck(:projects)
    end

    private

    def process_params(params)
      @user_id = params[:user_scope] || current_user.uuid
      @topic_id = params[:topic_id] || CYPHER_ANY
      @depth = "*0..#{params[:depth] || 2}"
      @friend_id = params[:friend_id] || CYPHER_ANY
      @visibility = ">= #{params[:visibility] || FRIENDS_VIZ}"
    end

    def by_topic(scope, topic_id)
      scope = scope.topic.where(id: topic_id) if topic_id
      scope
    end

    def exec_project_query
      ActiveGraph::Base.query(
        "MATCH (starter:Person)-[:`KNOWS`#{@depth}]-(friend:Person)
        -[:OWNS]->(project:Project)-[:CONCERNS]->(topic:Topic)
        WHERE starter.uuid =~ $uuid
        AND project.visibility <> 0
        AND project.visibility #{@visibility}
        AND friend.uuid =~ $friend_id
        AND topic.uuid =~ $topic_id
        RETURN DISTINCT project as projects
      ", topic_id: @topic_id, uuid: @user_id, friend_id: @friend_id
      )
    end
  end
end
