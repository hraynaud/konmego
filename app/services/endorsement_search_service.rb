require 'ostruct'
class EndorsementSearchService
  DEFAULT_NETWORK_HOPS = 3

  class << self
    def paths_to_resource current_user, topic, hops = DEFAULT_NETWORK_HOPS
      transform(current_user, get_endorsement_graph(current_user, topic, hops))
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
       topic_paths.map do |topic_path|
         topic_path
      end
    end

    def openstruct_to_hash(object, hash = {})
      case object
      when OpenStruct then
        object.each_pair do |key, value|
          hash[key] = openstruct_to_hash(value)
        end
        hash
      when Array then
        object.map { |v| openstruct_to_hash(v) }
      else object
      end
    end

    def extract_paths person, data
      data.map do |record|
        @extractor = ::PathExtractor.new(person,record)
        openstruct_to_hash(OpenStruct.new(path: @extractor.path, endorsement: @extractor.obfuscated_endorsement))
      end
    end



    #TODO FIXME 
    #1. Figure out how to use parameters in the relationship length clause
    #so that we don't have to string build (i.e. #{hops})
    #2. Is it possible to build this path query using the neo4j.rb ActiveNode DSL?
    #
    def match_query hops
      <<-CYPHER
 p = (u)-[:`KNOWS`*0..#{hops}]-(endorser:`Person`) 
 WITH *
 MATCH (endorser)<-[r_src:`ENDORSEMENT_SOURCE`]-(e:`Endorsement`) WHERE (e.status = 1)
 MATCH (e)-[r_target:`ENDORSEMENT_TARGET`]->(endorsee:`Person`) 
 MATCH (e)-[r_topic:`ENDORSE_TOPIC`]->(t:`Topic`) WHERE (t.name = {topic_name})
 WITH *
  WHERE ALL(x IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = x))
      CYPHER
    end
  end
end
