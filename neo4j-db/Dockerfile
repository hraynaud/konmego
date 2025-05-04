FROM neo4j:community-bullseye
ENV PASSWORD = $NEO4J_PASSWORD
# RUN mkdir -p /var/lib/neo4j/certificates/bolt
# COPY certificates/bolt /var/lib/neo4j/certificates/bolt
RUN mkdir -p /var/lib/neo4j/import
COPY init-constraints-indices.cql /var/lib/neo4j/import/
COPY init.sh /init.sh

# Make the script executable
RUN chmod +x /init.sh

# Set the extension script environment variable
# ENV EXTENSION_SCRIPT=/init.sh
# Neo4j auth will be set via environment variables during deployment
# NEO4J_AUTH will be set to "${NEO4J_USER}/${NEO4J_PASSWORD}"

# These ports are already exposed in the base image
EXPOSE 7474 7473 7687