class TopicSearchService
  DEFAULT_NETWORK_HOPS = 3

  class << self
    def paths_to_resource current_user, topic, hops = DEFAULT_NETWORK_HOPS
      transform(current_user, get_endorsement_graph(current_user, topic, hops))
    end

    def local_subgraph_from_person_and_topic person, topic, hops = DEFAULT_NETWORK_HOPS
      data = get_endorsement_graph(person, topic, hops)
      data.response
    end

    private

    def get_endorsement_graph current_user, topic, hops
      current_user.query_as(:u)
        .with(:u)
        .match(match_query(hops))
        .params(topic_name: topic)
        .return('relationships(p) as r_knows', 'nodes(p) as full_path', :r_src, :r_topic, :t, :e, :endorser, :endorsee)
    end

    def transform person, data
      topic_paths = extract_paths(person, data)
       topic_paths.map do |topc_path| 
        topc_path
      end
    end

    def extract_paths person, data
      data.map do |path|
       TopicPath.new(person, path)
      end
    end


    class TopicPath
      def initialize person, path
        @obfuscator = ::PathObfuscator.new(person,path)
        @obfuscator.obfuscate
      end

      def path
        @obfuscator.obfuscated_path
      end

      def endorsement
        @obfuscator.for_endorsement()
      end

    end

    #TODO FIXME 
    #1. Figure out how to use parameters in the relationship length clause
    #so that we don't have to string build (i.e. #{hops})
    #2. Is it possible to build this path query using the neo4j.rb ActiveNode DSL?
    #
    def match_query hops
      <<-CYPHER
 p = (u)-[:`KNOWS`*0..#{hops}]-(endorser:`Person`) WITH *
 MATCH (endorser)<-[r_src:`ENDORSEMENT_SOURCE`]-(e:`Endorsement`) WHERE (e.status = 1)
 MATCH (e)-[r_target:`ENDORSEMENT_TARGET`]->(endorsee:`Person`) 
 MATCH (e)-[r_topic:`ENDORSE_TOPIC`]->(t:`Topic`) WHERE (t.name = {topic_name})
      CYPHER
    end
  end
end
