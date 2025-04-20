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

# Start Rails
echo "Starting Rails app..."
exec "$@"