#!/bin/bash
set -e
source .env.neo4j

# Check that necessary env vars are set
: "${NEO4J_USER:?Environment variable NEO4J_USER must be set}"
: "${NEO4J_PASSWORD:?Environment variable NEO4J_PASSWORD must be set}"
: "${NEO4J_VOLUME_PATH:?Environment variable NEO4J_VOLUME_PATH must be set}"

# Default options
INTERACTIVE=false
ADMIN_MODE=false

# Parse flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    -i|--interactive)
      INTERACTIVE=true
      shift
      ;;
    -a|--admin)
      ADMIN_MODE=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: $0 [-i|--interactive] [-a|--admin]"
      exit 1
      ;;
  esac
done

# Base docker options
DOCKER_OPTS=(
  --name Neo4j
  --publish=7474:7474 --publish=7687:7687
  --env NEO4J_AUTH="${NEO4J_USER}/${NEO4J_PASSWORD}"
  --volume="${NEO4J_VOLUME_PATH}:/data"
  --volume="$(pwd)/backups:/var/lib/neo4j/backups"
)

# Adjust mode
if [ "$INTERACTIVE" = true ]; then
  DOCKER_OPTS+=(-it --rm)
else
  DOCKER_OPTS+=(--restart always -d)
fi

# Admin mode: keep container alive without starting Neo4j
if [ "$ADMIN_MODE" = true ]; then
  docker run "${DOCKER_OPTS[@]}" neo4j:community-bullseye bash -c "sleep infinity"
else
  docker run "${DOCKER_OPTS[@]}" neo4j:community-bullseye
fi