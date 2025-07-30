FROM neo4j:community-bullseye

ENV NEO4J_server_config_strict__validation_enabled=false

# Create import directory
RUN mkdir -p /var/lib/neo4j/import


# Copy files
COPY backups/neo4j.dump /var/lib/neo4j/import/
COPY init-constraints-indices.cql /var/lib/neo4j/import/
COPY init.sh /init.sh

RUN chmod +x /init.sh

# Set environment
ENV EXTENSION_SCRIPT=/init.sh

EXPOSE 7474 7473 7687