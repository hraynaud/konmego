class ProjectSearchService
  DEFAULT_PROJECT_SEARCH_DEPTH = 1
  class << self
    def search(user_scope, params = {})
      results = exec_project_query(user_scope, params[:topic])
      results.pluck(:projects)
    end

    private

    def by_topic(scope, topic_id)
      scope = scope.topic.where(id: topic_id) if topic_id
      scope
    end

    def exec_project_query(user_scope, topic = '.*', hops = 2, friend_id = '.*')
      ActiveGraph::Base.query(
        "MATCH (starter:Person)-[:`KNOWS`*1..#{hops}]-(friend:Person)
        -[:OWNS]->(project:Project)
        WHERE starter.uuid =~ $uuid
        AND friend.uuid =~ $friend_id
        RETURN DISTINCT project as projects
      ", topic: topic, uuid: user_scope, friend_id: friend_id
      )
    end
  end
end
