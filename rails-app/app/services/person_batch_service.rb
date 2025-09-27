


class PersonBatchService
  def self.fetch_people_by_ids(person_ids)
    return {} if person_ids.empty?

    # Single Neo4j query with WHERE n.uuid IN [...]
    people = Person.where(id: person_ids.uniq.compact)

    # Return as hash for O(1) lookup
    people.index_by(&:id)
  end
end
