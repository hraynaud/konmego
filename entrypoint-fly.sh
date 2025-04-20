#!/bin/bash
set -e
echo "!!! Starting Neo4j setup"
# Link data directory if needed
if [ -d "/rails-app/db/neo4j/development/data" ]; then
  echo "Moving existing data directory"
  mv /rails-app/db/neo4j/development/data /rails-app/db/neo4j/development/data.orig
fi

echo "Linking data volume"
ln -sf /rails-app/db/neo4j/data /rails-app/db/neo4j/development/data

if [ -f "/rails-app/db/neo4j/development/bin/neo4j-admin" ]; then
  echo "Configuring Neo4j authentication..."
  /rails-app/db/neo4j/development/bin/neo4j-admin dbms set-initial-password password || true
fi

echo "Starting Neo4j..."
/rails-app/db/neo4j/development/bin/neo4j start || true

# # Wait for Neo4j to start with timeout
# echo "Waiting for Neo4j to start..."
# TIMEOUT=30
# counter=0
# until curl -s http://localhost:7474 > /dev/null || [ $counter -eq $TIMEOUT ]; do
#   echo "Waiting for Neo4j... ($counter/$TIMEOUT)"
#   sleep 2
#   ((counter++))
# done

# if [ $counter -eq $TIMEOUT ]; then
#   echo "WARNING: Neo4j may not have started properly, but continuing with Rails startup"
# fi

# Temporarily remove schema loading for troubleshooting
# SCHEMA_FLAG="/rails-app/db/neo4j/schema_applied"
# if [ ! -f "$SCHEMA_FLAG" ]; then
#   echo "Setting up Neo4j schema from schema.yml..."
#   cd /rails-app
#   bundle exec rake neo4j:schema:load || true
#   touch "$SCHEMA_FLAG"
# fi

# Start Rails
echo "Starting Rails app..."
exec "$@"