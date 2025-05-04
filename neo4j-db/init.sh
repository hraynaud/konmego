#!/bin/bash

# Wait for Neo4j to start
echo "Waiting for Neo4j to start up..."
sleep 30

# Check if NEO4J_PASSWORD is set, if not, try to extract it from NEO4J_AUTH
if [ -z "$PASSWORD" ]; then
  if [ -n "$NEO4J_AUTH" ] && [[ "$NEO4J_AUTH" == */* ]]; then
    export PASSWORD=$(echo $NEO4J_AUTH | cut -d'/' -f2)
    echo "Extracted password from NEO4J_AUTH"
  else
    echo "ERROR: Neither NEO4J_PASSWORD nor NEO4J_AUTH is properly set"
    exit 1
  fi
fi

# Run the Cypher commands with retry logic
MAX_RETRIES=5
RETRY_COUNT=0
SUCCESS=false

while [ $RETRY_COUNT -lt $MAX_RETRIES ] && [ "$SUCCESS" != "true" ]; do
  echo "Attempt $((RETRY_COUNT+1)) to run Cypher commands..."
  
  if cat /var/lib/neo4j/import/init-constraints-indices.cql | cypher-shell -u neo4j -p "$PASSWORD" --fail-fast; then
    echo "Successfully executed Cypher commands!"
    SUCCESS=true
  else
    echo "Failed to execute Cypher commands. Retrying in 5 seconds..."
    RETRY_COUNT=$((RETRY_COUNT+1))
    sleep 5
  fi
done

if [ "$SUCCESS" != "true" ]; then
  echo "Failed to execute Cypher commands after $MAX_RETRIES attempts."
  exit 1
fi

echo "Initialization complete!"