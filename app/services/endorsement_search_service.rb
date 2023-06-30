require 'ostruct'
class EndorsementSearchService
  DEFAULT_NETWORK_HOPS = 3
  DEFAULT_ALL_TOPICS_REGEX = '.*'

  class << self
    def paths_to_resource(current_user, topic = nil, hops = nil)
      depth = hops || DEFAULT_NETWORK_HOPS
      graph = get_endorsement_graph(current_user, topic, depth)
      data = graph.pluck(:all_paths, :e)
      extract_paths(current_user, data)
    end

 

    private

    def get_endorsement_graph(current_user, topic, hops)
      t = topic || DEFAULT_ALL_TOPICS_REGEX
      ActiveGraph::Base.query("
        Match p = (:Person {uuid: $uuid})-[:`KNOWS`*0..#{hops}]-(endorsee:Person)-[e:ENDORSES]-(endorser:Person)
        WHERE e.topic =~ $topic
        WITH *
        WHERE ALL(x IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = x))
        RETURN nodes(p) as all_paths, e",
                              topic: t, uuid: current_user.uuid)
    end

    def by_topic; end

    def by_time_frame; end

    def extract_paths(person, data)
      data.map do |path, endorsement|
        @extractor = ::PathExtractor.new(person, path, endorsement)
        @extractor.obfuscate
      end
    end
  end
end
