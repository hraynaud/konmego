#!/bin/bash
sleep 30

if [ -n "$NEO4J_AUTH" ] && [[ "$NEO4J_AUTH" == */* ]]; then
  PASSWORD=$(echo $NEO4J_AUTH | cut -d'/' -f2)
  echo "Extracted password from NEO4J_AUTH"
else
  echo "ERROR: NEO4J_AUTH not properly set"
  exit 1
fi

# Check if empty, then import
NODE_COUNT=$(echo "MATCH (n) RETURN count(n);" | cypher-shell -u neo4j -p "$PASSWORD" 2>/dev/null | tail -n 1)

if [ "$NODE_COUNT" = "0" ] 2>/dev/null; then
  neo4j stop
  sleep 10
  neo4j-admin database load neo4j --from-path=/var/lib/neo4j/import --overwrite-destination=true
  neo4j start
  sleep 30
fi

echo "Done"