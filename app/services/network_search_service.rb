class NetworkSearchService

  def self.find_skill person, skill, max_hops_away = 3
    person.contacts(:contact, :r, rel_length: 0..max_hops_away)
      .outgoing_endorsements(:e)
      .accepted
      .topic(:t)
      .where('t.name = ?',skill)
      .pluck('distinct contact')
  end

end
