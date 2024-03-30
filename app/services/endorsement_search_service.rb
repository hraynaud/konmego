class EndorsementSearchService
  DEFAULT_NETWORK_HOPS = 3
  DEFAULT_TOLERANCE = 0.78
  DEFAULT_ALL_TOPICS_REGEX = '.*'.freeze
  DEFAULT_LIMIT = 10

  SEARCH_PROMPT = %(
    The following text represents a natural
    language search for a particular skill or talent. Identify the key
    skills, talents, and relevant terms that capture the competencies being sought out.
    Here is the recommendation text:
    ).freeze

  SEARCH_INSTR = %(

    Read the search text carefully.

    Generate 20 synonyms or related terms in the same category or knowledge domain as the search text.
    Do not include any commentary or explanatory text.
    Your response will be processed electronically so it must only include JSON.
    Output the data only in this exact JSON format:  {"terms":["term 1 ", "term 2", "term 3",...]}
    Do not include any helpful commentary or follow up questions in the response output.


    ).freeze

  class << self
    def search(current_user, **args)
      hops = args[:hops] || DEFAULT_NETWORK_HOPS
      tolerance = args[:tolerance] || DEFAULT_TOLERANCE
      topic = TopicService.find_by_name(args[:topic_name])
      skip = (args[:page] ? args[:page].to_i - 1 : 0) * DEFAULT_LIMIT
      if args[:query]
        by_vector current_user.uuid, args[:query], topic, hops, tolerance, skip
      else
        topic_name = topic&.name
        exec_endorsement_query current_user.uuid, topic_name, hops, skip
      end
    end

    def optimize_for_embedding(query)
      search_prompt = build_search_prompt(query)
      completion = OllamaService.completion(search_prompt)
      OllamaService.parse_completion completion
    end

    def build_search_prompt(search)
      "#{SEARCH_PROMPT} \n __\n #{search} \n ___ #{SEARCH_INSTR}"
    end

    private

    def topic_terms(topic)
      TopicService.find(topic)
    end

    def by_vector(user_uuid, query, topic, hops, tolerance, skip)
      optimized_text = optimize_for_embedding(query)
      qry_vector = OllamaService.embedding("#{topic.like_terms} \n #{optimized_text}")
      do_vector_query(user_uuid, qry_vector, hops, tolerance, skip)
    end

    def do_vector_query(user_uuid, qry_vector, hops, tolerance, skip, limit=DEFAULT_LIMIT) # rubocop:disable Metrics/MethodLength
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
    ORDER BY score desc SKIP $skip LIMIT $limit
    ", user_uuid:, qry_vector:, tolerance:, skip:,limit:
      )
    end

    def exec_endorsement_query(user_uuid, topic, hops, skip, limit=DEFAULT_LIMIT)
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
     ORDER BY t.name SKIP $skip LIMIT $limit
     ", topic:, uuid: user_uuid, skip:, limit:
      )
    end
  end
end
