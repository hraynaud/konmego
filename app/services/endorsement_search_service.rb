class EndorsementSearchService
  DEFAULT_NETWORK_HOPS = 3
  DEFAULT_TOLERANCE = 0.78
  DEFAULT_ALL_TOPICS_REGEX = '.*'.freeze

  SEARCH_PROMPT = %(
    You are an expert in semantic search. The following text represents a natural
    language search for a particular skill or talent. Identify the key
    skills, talents, and relevant terms that capture the competencies being sought out.
    Here is the recommdation text:
    ).freeze

  SEARCH_INSTR = %(
    Read the search text carefully.
    Identify and list the main skills, talents, or attributes mentioned that are relevant to the search.
    In order to ensure that the search finds as many matches as possible add at least 10 related terms within the same
    category or knowledge domain to ensure the search doesn't rely strictly on exact matches.
    I trust your judgement so please do not include any commentary or explanatory text.
    Please combine the list of skills and related terms into a JSON array in the following format:
    {"keywords": [term1, term2, term3, ...]}
    limit your response to the JSON array.
    ).freeze

  class << self
    def search(current_user, opts)
      hops = opts[:hops] || DEFAULT_NETWORK_HOPS
      tolerance = opts[:tolerance] || DEFAULT_TOLERANCE
      optimized_text = optimize_for_embedding(opts[:query])
      qry_vector = OllamaService.create_embedding(optimized_text)

      do_vector_query(current_user.uuid, qry_vector, hops, tolerance)
    end

    def optimize_for_embedding(query)
      search_prompt = build_search_prompt(query)
      OllamaService.completion(search_prompt)
    end

    def build_search_prompt(search)
      "#{SEARCH_PROMPT} \n __\n #{search} \n ___ #{SEARCH_INSTR}"
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
