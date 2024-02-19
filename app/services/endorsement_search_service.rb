class EndorsementSearchService
  DEFAULT_NETWORK_HOPS = 3
  DEFAULT_ALL_TOPICS_REGEX = '.*'.freeze

  class << self
    def search(current_user, topic = nil, hops = nil)
      topic ||= DEFAULT_ALL_TOPICS_REGEX
      hops ||= DEFAULT_NETWORK_HOPS
      exec_endorsement_query(current_user, topic, hops)
    end

    private

    def exec_endorsement_query(current_user, topic, hops)
      ActiveGraph::Base.query(
        "MATCH p= (starter:Person {uuid: $uuid})-[:`KNOWS`*0..#{hops}]
        -(endorser:`Person`)<-[r_src:`ENDORSEMENT_SOURCE`]-(e:`Endorsement`)
      MATCH (e)-[r_target:`ENDORSEMENT_TARGET`]->(endorsee:`Person`)
      MATCH (e)-[r_topic:`TOPIC`]->(t:`Topic`)
      WHERE (e.description CONTAINS $topic)
      WITH *
     WHERE ALL(x IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = x))
     return relationships(p) as r_knows, nodes(p) as full_path", topic:, uuid: current_user.uuid
      )
    end
  end
end
