class TopicSearchService
  DEFAULT_NETWORK_HOPS = 3

  class << self
    def paths_to_resource person, topic, hops = DEFAULT_NETWORK_HOPS
      obfuscate(person, get_endorsement_graph(person, topic, hops))
    end

    def local_subgraph_from_person_and_topic person, topic, hops = DEFAULT_NETWORK_HOPS
      get_endorsement_graph(person, topic, hops).response
    end


    def get_endorsement_graph person, topic, hops
      person.query_as(:u)
        .with(:u)
        .match(match_query(hops))
        .params(topic_name: topic)
        .return('relationships(p) as r_knows', 'nodes(p) as full_path', :r_src, :r_topic, :t, :e, :endorser, :endorsee)
    end
    private

    def obfuscate person, data
      o =  Obfuscator.new(person)
      data.map(&:full_path).map do |path| 
        path.map do |n|
          o.obfuscate(n)
        end
      end
    end


    def extract_paths data
      data.map(&:full_path)
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
