#!/bin/bash

# Start Neo4j only if the script is not run interactively
if [ -t 1 ]; then
  echo "Running interactively, skipping Neo4j and Rails startup"
  exec "$@"  # Allow passing commands interactively (e.g., bash)
else    
  echo "Starting Neo4j..."
  # neo4j start
  bundle exec rake 'neo4j:start[development]'

  # Wait for Neo4j to be fully up (optional)
  until curl -s http://localhost:7474 > /dev/null; do
    echo "Waiting for Neo4j to start..."
    sleep 2
  done

  # Start Rails
  echo "Starting Rails app..."
  exec "$@"
fi