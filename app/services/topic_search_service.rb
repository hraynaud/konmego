class TopicSearchService

  def self.paths_and_connections_from person, topic, hops = 3
    paths_for(person, topic, hops).map do |p| 
      p.map{|u|"#{u.properties[:first_name]}, #{u.properties[:last_name]}"}
    end
  end

  def self.paths_for person, topic, hops
    person.query_as(:u)
      .with(:u)
      .match(match_query(hops))
      .params(topic_name: topic)
      .return(:p)
      .map(&:p)
      .map(&:nodes)

  end

  def self.find_contacts_connected_to_topic_for person, topic, max_hops_away = 3
    p = contact_path(person, topic, max_hops_away)
    p.pluck('distinct contact')
  end

  def self.contact_path person, topic, max_hops_away
    accepted_connected_endorsments(person, topic, max_hops_away)
      .topic(:t)
      .where('t.name = ?',topic)
  end

  def self.accepted_connected_endorsments person, topic, max_hops_away
    #NOTE the ':r' capturing the relationship is required here in order to use
    #rel_length
    person.contacts(:contact, :r, rel_length: 0..max_hops_away)
      .outgoing_endorsements(:e)
      .accepted
  end


  #TODO FIXME 
  #1. Figure out how to use parameters in the relationship length clause
  #so that we don't have to string build (i.e. #{hops})
  #2. Is it possible to build this path query using the neo4j.rb ActiveNode DSL?
  #
  def self.match_query hops
    <<-CYPHER
 p = (u)-[r:`KNOWS`*0..#{hops}]-(contact:`Person`)
 MATCH (contact)<-[:`ENDORSEMENT_SOURCE`]-(e:`Endorsement`) WHERE (e.status = 1)
 MATCH (e)-[:`ENDORSE_TOPIC`]->(t:`Topic`) WHERE (t.name = {topic_name})
    CYPHER
  end
end
