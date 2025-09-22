# ActiveGraph N+1 Query Optimization

## Problem Description

ActiveGraph exhibits different association caching behavior compared to ActiveRecord, leading to severe N+1 query performance issues when serializing objects with associations.

### Core Issues Identified

1. **Association Access Triggers Fresh Queries**: Unlike ActiveRecord, calling `project.topic` or `project.owner` in ActiveGraph executes a new database query each time, even if previously accessed.

2. **Serializer N+1 Queries**: JSON serializers accessing associations repeatedly caused massive query proliferation:
   - Person endpoint: 25+ seconds with dozens of N+1 queries
   - Projects endpoint: 13+ seconds with 30+ individual association queries

3. **Simple Preloading Insufficient**: Traditional ActiveGraph preloading methods (`.to_a`, `with_associations`) were unreliable for consistent association caching.

## Solution Strategies

### Strategy 1: Simple Association Preloading (Person Endpoint)
For cases where ActiveGraph's caching works predictably:

```ruby
def show
  person = Person.find_by(uuid: params[:id])
  
  # Force load associations to cache them
  person.contacts.to_a
  person.outgoing_endorsements.to_a
  person.incoming_endorsements.to_a
  person.projects.to_a
  
  # Preload current user's contact IDs for permission checks
  current_user_contact_ids = current_user&.contacts&.pluck(:id) || []
  
  options = {
    params: {
      current_user: current_user,
      current_user_contact_ids: current_user_contact_ids
    }
  }
  
  render json: PersonSerializer.new(person, options).serializable_hash.to_json
end

```

Strategy 2: Custom Cypher + Association Override (Projects Endpoint)
For cases where association caching is unreliable:

```ruby
# In ProjectSearchService
def search(params)
  process_params params
  results = exec_project_query
  
  # Create projects with preloaded associations
  results.map do |row|
    project = row[:project] 
    topic = row[:topic]
    owner = row[:owner]
    
    # Override association methods with preloaded data
    project.define_singleton_method(:topic) { topic }
    project.define_singleton_method(:owner) { owner }
    
    project
  end.uniq(&:uuid)
end

def exec_project_query
  ActiveGraph::Base.query(
    "MATCH (starter:Person)-[:`KNOWS`#{@depth}]-(friend:Person)
    -[:OWNS]->(project:Project)-[:CONCERNS]->(topic:Topic)
    WHERE starter.uuid =~ $uuid
    AND project.visibility <> 0
    AND project.visibility #{@visibility}
    AND friend.uuid =~ $friend_id
    AND topic.uuid =~ $topic_id
    RETURN DISTINCT project, topic, friend as owner
  ", topic_id: @topic_id, uuid: @user_id, friend_id: @friend_id
  )
end
```
Strategy 3: Permission Check Optimization
Eliminate N+1 queries in permission checking by preloading contact IDs:

# In serializers
```ruby
class ProjectSerializer
  class << self
    def can_show?(current_user, contact, params = nil)
      if current_user
        return true if current_user == contact
        
        # Use preloaded contact IDs to avoid N+1 queries
        if params && params[:current_user_contact_ids]
          params[:current_user_contact_ids].include?(contact.id)
        else
          current_user.friends_with?(contact)
        end
      else
        false
      end
    end
  end
end
```