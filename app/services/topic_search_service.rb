class TopicSearchService

  def self.find_contacts_connected_to_topic_for person, topic, max_hops_away = 3
    person.contacts(:contact, :r, rel_length: 0..max_hops_away)
      .outgoing_endorsements(:e)
      .accepted
      .topic(:t)
      .where('t.name = ?',topic)
      .pluck('distinct contact')
  end

end
