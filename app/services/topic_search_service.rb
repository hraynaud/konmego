class TopicSearchService
  DEFAULT_NETWORK_HOPS = 3

  def self.search_endorsing_contacts person, topic, hops = DEFAULT_NETWORK_HOPS
    get_graph_elements(local_subgraph_from_person_and_topic(person, topic, hops) , :contact)
  end

  def self.get_graph_elements data, element 
    data.map{|d|d.send(element.to_sym)}
  end

  def self.local_subgraph_from_person_and_topic person, topic, hops = DEFAULT_NETWORK_HOPS
    person.query_as(:u)
      .with(:u)
      .match(match_query(hops))
      .params(topic_name: topic)
      .return('relationships(p) as r_knows', 'nodes(p) as peeps', :r_src, :r_topic, :t, :e, :contact )
  end

  #TODO FIXME 
  #1. Figure out how to use parameters in the relationship length clause
  #so that we don't have to string build (i.e. #{hops})
  #2. Is it possible to build this path query using the neo4j.rb ActiveNode DSL?
  #
  def self.match_query hops
    <<-CYPHER
 p = (u)-[:`KNOWS`*1..#{hops}]-(contact:`Person`) WITH *
 MATCH (contact)<-[r_src:`ENDORSEMENT_SOURCE`]-(e:`Endorsement`) WHERE (e.status = 1)
 MATCH (e)-[r_target:`ENDORSEMENT_TARGET`]->(endorsee:`Person`) 
 MATCH (e)-[r_topic:`ENDORSE_TOPIC`]->(t:`Topic`) WHERE (t.name = {topic_name})
    CYPHER
  end

end
