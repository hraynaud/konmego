class EndorsementSearchService
  DEFAULT_NETWORK_HOPS = 3
  DEFAULT_TOLERANCE = 0.60
  DEFAULT_ALL_TOPICS_REGEX = '.*'.freeze
  DEFAULT_LIMIT = 10

  SEARCH_PROMPT = %(
    You are powerful semantic search and thesaurus robot that only responds in JSON.
    You reply in JSON format with the field 'terms'.
    Given some text you will Identify the key
    skills, talents, and competencies related to the text.

    You must read the text carefully.
    You Generate 20 synonyms or related terms in the same category or knowledge domain as the search text.
    Here is the expected JSON format:  {"terms":["term 1 ", "term 2", "term 3",...]}
    Example text: "who do I know in the culinary arts" your response would look like this:
    Example answer:{ "terms": ["Cooking", "Culinary Skills", "Food Preparation", "Recipe Development", "Kitchen Management", "Menu Planning", "Food Styling"]}'
    Here is the text:
    ).freeze

  class << self
    def search(current_user, **args)
      hops, tolerance, skip, query, topic = extract_args(args)
      if query
        by_vector current_user.uuid, args[:query], topic.try(:like_terms), hops, tolerance, skip
      else
        topic_name = topic&.name
        exec_endorsement_query current_user.uuid, topic_name, hops, skip
      end
    end

    def extract_args(args)
      hops = args[:hops] || DEFAULT_NETWORK_HOPS
      tolerance = args[:tolerance] || DEFAULT_TOLERANCE
      skip = (args[:page] ? args[:page].to_i - 1 : 0) * DEFAULT_LIMIT
      query = args[:query]
      topic = derive_topic(args[:topic_name], query)
      [hops, tolerance, skip, query, topic]
    end

    def derive_topic(topic_name, query)
      topic_name ||= TopicSuggestionService.suggest(query)
      TopicService.find_by_name(topic_name)
    end

    def optimize_for_embedding(query)
      search_prompt = build_search_prompt(query)
      completion = OllamaService.completion(search_prompt)
      OllamaService.parse_completion completion
    end

    def build_search_prompt(search)
      "#{SEARCH_PROMPT} \n __\n #{search} \n"
    end

    private

    def topic_terms(topic)
      TopicService.find(topic)
    end

    def by_vector(user_uuid, query, like_terms, hops, tolerance, skip) # rubocop:disable Metrics/ParameterLists
      # TODO continue experimenting with optimizing the text
      # optimized_text = optimize_for_embedding(query)
      # qry_vector = OllamaService.embedding("#{optimized_text} \n #{query}")
      qry_vector = OllamaService.embedding("#{query}\n  #{like_terms} ")

      do_vector_query(user_uuid, qry_vector, hops, tolerance, skip)
    end

    def do_vector_query(user_uuid, qry_vector, hops, tolerance, skip, limit = DEFAULT_LIMIT) # rubocop:disable Metrics/MethodLength, Metrics/ParameterLists
      ActiveGraph::Base.query(
        "
    MATCH p= allShortestPaths((starter:Person {uuid:  $user_uuid})-[:`KNOWS`*0..#{hops}]-(endorser:`Person`))
    WITH p, endorser
    CALL db.index.vector.queryNodes('endorsementText', 3, $qry_vector) YIELD node as e,score
    WHERE score >= $tolerance
    MATCH (endorser)<-[r_src:`ENDORSEMENT_SOURCE`]-(e)-[r_target:`ENDORSEMENT_TARGET`]->(endorsee)
    MATCH (e)-[r_topic:`TOPIC`]->(t:`Topic`)

    WITH p, relationships(p) AS r_knows, e, r_src, r_topic, t, endorser, endorsee,score
    WHERE ALL(x IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = x))
    RETURN  nodes(p) as all_paths, e, score
    ORDER BY score desc SKIP $skip LIMIT $limit
    ", user_uuid:, qry_vector:, tolerance:, skip:, limit:
      )
    end

    def exec_endorsement_query(user_uuid, topic, hops, skip, limit = DEFAULT_LIMIT) # rubocop:disable Metrics/MethodLength
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
