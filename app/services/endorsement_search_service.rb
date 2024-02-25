class EndorsementSearchService
  DEFAULT_NETWORK_HOPS = 3
  DEFAULT_TOLERANCE = 0.78
  DEFAULT_ALL_TOPICS_REGEX = '.*'.freeze

  class << self
    def search(current_user, opts)
      hops = opts[:hops] || DEFAULT_NETWORK_HOPS
      tolerance = opts[:tolerance] || DEFAULT_TOLERANCE
      qry_vector = OllamaService.create_embedding(opts[:query])

      do_vector_query(current_user.uuid, qry_vector, hops, tolerance)
    end

    private

    def do_vector_query(user_uuid, qry_vector, hops, tolerance) # rubocop:disable Metrics/MethodLength
      ActiveGraph::Base.query(
        "
    MATCH p= allShortestPaths((starter:Person {uuid:  $user_uuid})-[:`KNOWS`*0..#{hops}]-(endorser:`Person`))
    WITH p, endorser
    CALL db.index.vector.queryNodes('endorsement-embeddings', 3, $qry_vector) YIELD node as e,score
    WHERE score >= $tolerance
    MATCH (endorser)<-[r_src:`ENDORSEMENT_SOURCE`]-(e)-[r_target:`ENDORSEMENT_TARGET`]->(endorsee)
    MATCH (e)-[r_topic:`TOPIC`]->(t:`Topic`)

    WITH p, relationships(p) AS r_knows, e, r_src, r_topic, t, endorser, endorsee,score
    WHERE ALL(x IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = x))
    RETURN  nodes(p) as all_paths, e, score
    ORDER BY score desc
    ", user_uuid:, qry_vector:, tolerance:
      )
    end

    def exec_endorsement_query(current_user, topic, hops) # rubocop:disable Metrics/MethodLength
      ActiveGraph::Base.query(
        "MATCH p= allShortestPaths((starter:Person {uuid: $uuid})-[:`KNOWS`*0..#{hops}]-(endorser:`Person`))
        WITH *
      MATCH (endorser)<-[r_src:`ENDORSEMENT_SOURCE`]-(e:`Endorsement`)
      MATCH (e)-[r_target:`ENDORSEMENT_TARGET`]->(endorsee:`Person`)
      MATCH (e)-[r_topic:`TOPIC`]->(t:`Topic`)
      WHERE (($topic IS NOT NULL AND e.description CONTAINS $topic) OR
       ($topic IS NULL AND e.description =~ '.*')) AND endorsee.uuid <> $uuid
      WITH *
     WHERE ALL(x IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = x))
     return nodes(p) as all_paths, e
     ORDER BY t.name
     ", topic:, uuid: current_user.uuid
      )
    end
  end
end
