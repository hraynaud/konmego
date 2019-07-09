class NetworkSearchService

  def self.find_skill person, skill, max_hops_away = 3
    person.contacts(:contact, :r, rel_length: 1..3).outgoing_endorsements.topic(:t).where('t.name = ?',skill).pluck('distinct contact')
  end

end
