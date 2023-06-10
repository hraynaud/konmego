require 'ostruct'
class EndorsementSearchService
  DEFAULT_NETWORK_HOPS = 3

  class << self
    def paths_to_resource(current_user, topic, hops = DEFAULT_NETWORK_HOPS)
      graph = get_endorsement_graph(current_user, topic, hops)
      graph.pluck(:all_paths)
      # transform(current_user, graph)
    end

    private

    def get_endorsement_graph(current_user, topic, hops)
       ActiveGraph::Base.query("
        Match p = (:Person {uuid: $uuid})-[:`KNOWS`*0..#{hops}]-(endorsee:Person)-[e:ENDORSES {topic: $topic}]-(endorser:Person)
        WITH *
        WHERE ALL(x IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = x))
        RETURN p, [n IN nodes(p) | n.name] AS all_paths, endorsee.name, endorser.name",
       topic: topic, uuid: current_user.uuid)        
    end

    def transform(person, data)
      topic_paths = extract_paths(person, data)
      topic_paths.map do |topic_path|
        topic_path
      end
    end

    def extract_paths(person, data)

      data.map do |record|
        @extractor = ::PathExtractor.new(person, record)
        openstruct_to_hash(OpenStruct.new(path: @extractor.path, endorsement: @extractor.obfuscated_endorsement))
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

    

  end
end
