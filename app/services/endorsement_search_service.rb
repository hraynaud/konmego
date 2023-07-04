require 'ostruct'
class EndorsementSearchService
  DEFAULT_NETWORK_HOPS = 3
  DEFAULT_ALL_TOPICS_REGEX = '.*'

  class << self
  
    def search(current_user, topic = nil, hops = nil)
      topic = topic || DEFAULT_ALL_TOPICS_REGEX
      hops = hops || DEFAULT_NETWORK_HOPS
      exec_endorsement_query(current_user, topic, hops)
    end
 


    private

    def exec_endorsement_query(current_user, topic, hops)
      ActiveGraph::Base.query("
        Match p = (starter:Person {uuid: $uuid})-[:`KNOWS`*0..#{hops}]-(endorsee:Person)-[e:ENDORSES]-(endorser:Person)
        WHERE e.topic =~ $topic
        WITH p,e

        WHERE ALL(x IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = x))
      
        RETURN nodes(p) as all_paths, e",
                              topic: topic, uuid: current_user.uuid)
    end

  end
end
