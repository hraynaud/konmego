#!/bin/bash
set -e
source .env.neo4j

# Check that necessary env vars are set
: "${NEO4J_USER:?Environment variable NEO4J_USER must be set}"
: "${NEO4J_PASSWORD:?Environment variable NEO4J_PASSWORD must be set}"
: "${NEO4J_VOLUME_PATH:?Environment variable NEO4J_VOLUME_PATH must be set}"
    
docker run \
    --name Neo4j \
    --restart always \
    --publish=7474:7474 --publish=7687:7687 \
    --env NEO4J_AUTH="${NEO4J_USER}/${NEO4J_PASSWORD}" \
    --volume="${NEO4J_VOLUME_PATH}:/data" \
    neo4j:community-bullseye
