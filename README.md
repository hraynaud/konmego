## neo4j aura

- create instance
- import the data

# Fly.io setup for each component from scratch
cd into the appropriate folder then execute
### postgres
```
fly postgres create --name konmego-postgres --region ewr
fly volumes create postgres_data --size 10
fly secrets set POSTGRES_USER=your_user POSTGRES_PASSWORD=your_secure_password
```


## Rails Server
```
fly launch --name konmego-server --no-deploy
# Configure environment variables to connect to other services
fly secrets set DATABASE_URL=postgres://your_user:your_secure_password@konmego-postgres.internal:5432/konmego
fly secrets set NEO4J_HOST=konmego-neo4j.internal
fly secrets set NEO4J_PORT=7687
fly secrets set NEO4J_USER=neo4j
fly secrets set NEO4J_PASSWORD=your_secure_password
fly secrets set OLLAMA_SERVER_ADDRESS=http://konmego-ollama.internal:11434
#change for other environments
fly secrets set RAILS_MASTER_KEY=$(cat config/credentials/development.key)
fly secrets set RAILS_ENV=development 
fly deploy  
```

## Ollama
```
fly launch --name konmego-ollama --no-deploy
fly volumes create ollama_data --size 20
fly scale memory 4096 --vm-size performance-1x
# Models will be pulled during initialization
fly deploy
```




# Deployment Issues and Solutions

When deploying our Rails/Neo4j/Quasar application to Fly.io, we encountered several challenges. This document summarizes these issues and their solutions for future reference.

## Neo4j Installation Missing

**Issue:** The Neo4j directory was excluded by `.dockerignore`, causing the app to fail when trying to start Neo4j.

**Solution:** Modified `.dockerignore` to specifically include the Neo4j development directory and its contents:
```
# Keep Neo4j development files
!rails-app/db/neo4j/development
!rails-app/db/neo4j/development/**
```
## Docker Volume Mounting Complications

**Issue:** Fly.io volume mounting was replacing the Neo4j installation with an empty volume.

**Solution:** Changed the mount point to target only the data directory rather than the entire Neo4j installation:

```toml
[mounts]
  source = "neo4j_data"
  destination = "/rails-app/db/neo4j/data"
```


## Neo4j Auto-start Issues
**Issue**: 
Neo4j startup command was accidentally removed from the entrypoint script.

**Solution**: 
Restored the Neo4j start command in the entrypoint script:

```/rails-app/db/neo4j/development/bin/neo4j start || true```

## Neo4j Authentication Failures
**Issue:** Neo4j authentication context wasn't transferring to the new environment.

**Solution:** Added password configuration to the entrypoint script:

```
if [ -f "/rails-app/db/neo4j/development/bin/neo4j-admin" ]; then
  echo "Configuring Neo4j authentication..."
  /rails-app/db/neo4j/development/bin/neo4j-admin dbms set-initial-password password || true
fi
```

### NOTE
For production, use environment variables instead:

```
fly secrets set NEO4J_PASSWORD=your_secure_password
```
then in neo4j.yml do this:
```
production:
  url: bolt://localhost:7687
  username: neo4j
  password: <%= ENV['NEO4J_PASSWORD'] %>
```

and in the entrypoint-fly.sh do this:
```
if [ -f "/rails-app/db/neo4j/development/bin/neo4j-admin" ]; then
  echo "Configuring Neo4j authentication..."
  /rails-app/db/neo4j/development/bin/neo4j-admin dbms set-initial-password "${NEO4J_PASSWORD}" || true
fi
```

## Quasar Frontend Port Mismatch
**Issue:** 
The Quasar frontend was listening on port 8043 while Fly.io expected port 3000.

**Solution:** 
Updated the internal_port in fly.toml or modified the CMD to specify port 3000:

## Auto-stopping in Fly.io
**Issue:** Fly.io was automatically stopping the machine after periods of inactivity.

**Solution:** Updated fly.toml to disable auto-stopping:

```
[http_service]
  auto_stop_machines = false
  min_machines_running = 1
```