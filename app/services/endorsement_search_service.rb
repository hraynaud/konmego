class EndorsementSearchService
  DEFAULT_NETWORK_HOPS = 3
  DEFAULT_ALL_TOPICS_REGEX = '.*'.freeze

  class << self
    def search(current_user, topic = nil, hops = nil)
      topic ||= DEFAULT_ALL_TOPICS_REGEX
      hops ||= DEFAULT_NETWORK_HOPS
      exec_endorsement_query(current_user, topic, hops)
    end

    private

    def exec_endorsement_query(current_user, topic, hops) # rubocop:disable Metrics/MethodLength
      ActiveGraph::Base.query(
        "MATCH p = allShortestPaths((starter:Person {uuid: $uuid})-[:`KNOWS`|`ENDORSES`*0..#{hops}]-(endorser:Person))
      WHERE ALL(node IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = node))
      WITH p, endorser
      MATCH (endorser)-[e:ENDORSES]->(endorsee:Person)
      WHERE e.topic =~ $topic
      WITH e, nodes(p) AS pathNodes, endorsee, length(p) AS pathLength
      ORDER BY pathLength ASC
      RETURN DISTINCT e,
          CASE WHEN endorsee IN pathNodes THEN pathNodes ELSE pathNodes + endorsee END AS all_paths
      ", topic: topic, uuid: current_user.uuid
      )
    end
  end
end
