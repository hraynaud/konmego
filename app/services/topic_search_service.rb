class TopicSearchService

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
    person.contacts(:contact, :r, rel_length: 0..max_hops_away)
      .outgoing_endorsements(:e)
      .accepted
  end


  def self.nodes_for person, topic, max_hops
    #call apoc.path.expand( u, 'KNOWS', 'Person', 0, {max_hops}) yield path
    #WITH path

    Person.where(id: person.id).query_as(:u).with(:u)
      .match("p = (u)-[r:`KNOWS`*0..3]-(contact:`Person`)
  MATCH (contact)<-[:`ENDORSEMENT_SOURCE`]-(e:`Endorsement`) WHERE (e.status = 1)
  MATCH (e)-[:`ENDORSE_TOPIC`]->(t:`Topic`) WHERE (t.name = {topic_name})")
      .params(topic_name: topic, max_hops: max_hops)
      .return(:p)
      .map(&:p)
      .map(&:nodes)
  end

end
