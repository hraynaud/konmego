class EndorsementSearchService
  DEFAULT_NETWORK_HOPS = 3
  DEFAULT_ALL_TOPICS_REGEX = '.*'.freeze

  class << self
    def search(current_user, topic = nil, hops = nil)
      hops ||= DEFAULT_NETWORK_HOPS
      exec_endorsement_query(current_user, topic, hops)
    end

    def paths_to_resource(current_user, topic, hops = DEFAULT_NETWORK_HOPS)
      graph = exec_endorsement_query(current_user, topic, hops)
      transform(current_user, graph)
    end

    private

    def get_endorsement_graph(current_user, topic, hops)
      current_user.query_as(:u)
                  .with(:u)
                  .match(match_query(hops))
                  .params(topic_name: topic)
                  .return('relationships(p) as r_knows', 'nodes(p) as full_path', :r_src, :r_topic, :t, :e, :endorser, :endorsee)
    end

    def transform(person, data)
      topic_paths = extract_paths(person, data)
      topic_paths.map do |topic_path|
        topic_path
      end
    end

    def openstruct_to_hash(object, hash = {})
      case object
      when OpenStruct
        object.each_pair do |key, value|
          hash[key] = openstruct_to_hash(value)
        end
        hash
      when Array
        object.map { |v| openstruct_to_hash(v) }
      else object
      end
    end

    def extract_paths(person, data)
      data.map do |record|
        @extractor = ::PathExtractor.new(person, record)
        openstruct_to_hash(OpenStruct.new(path: @extractor.path, endorsement: @extractor.obfuscated_endorsement))
      end
    end

    def match_query(hops)
      <<-CYPHER
  MATCH p= (u:Person {uuid: $uuid})-[:`KNOWS`*0..#{hops}]-(endorser:`Person`)
 WITH *
 MATCH (endorser)<-[r_src:`ENDORSEMENT_SOURCE`]-(e:`Endorsement`) WHERE (e.status = 1)
 MATCH (e)-[r_target:`ENDORSEMENT_TARGET`]->(endorsee:`Person`)
 MATCH (e)-[r_topic:`TOPIC`]->(t:`Topic`) WHERE t.name = $topic_name
 WITH *
  WHERE ALL(x IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = x))
      CYPHER
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
     return relationships(p) as r_knows, nodes(p) as all_paths, r_src, r_topic, t, e, endorser, endorsee
     ORDER BY t.name
     ", topic:, uuid: current_user.uuid
      )
    end
  end
end
