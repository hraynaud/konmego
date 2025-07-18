# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

# Database initialization

FYI: NEO4J only runs on Java 8 or below

neo4j settings located in db neo4j[development,test]/conf/neo4j.conf folder
neo4j.yml config which controls rails connection must match the settings in the
neo4j.conf file.

DO NOT SET NEO4J_HOME OR URL unless you are using a stand_alone_instance of
NEO4J and not the emebedded one that is installed via the neo4j rake task gem. Otherwise all
environments test and development will look for NEO4J db in NEO4J_HOME directory

## Database creation

Install the latest neo4j version to the desired environment as follows:  
`rake neo4j:install[community-latest,development] `

Note if community-latest doesn't work you might need to specify the exact version. Even then it might now work so may have to download the tar file and unzip in the appropriate directory under db/neo4j/[ENVIRONMENT]

- see https://github.com/neo4jrb/neo4j-rake_tasks for instructions on how to initialize the db after starting.

- For new neo4j setup run `rake neo4j:generate_schema_migration[constraint,Identity,uuid]`
  the run `rake neo4j:migrate` -- prefix this with RAILS_ENV="test" for the test environment

- update the neo4j.yaml file to match the port numbers you specified when running the config rake task eg:  
  `rake neo4j:config[development,7000]`

- Data loading

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- env-local:

it is helpful to create an alias like so in your bash file to cd to this project.

alias mego="cd dev-work/konmego/;source aliases.sh"

Which creates these aliases below

- alias start_dev_db="bundle exec rake 'neo4j:start[development]'"
- alias start_test_db="bundle exec rake 'neo4j:start[test]'"
- alias stop_dev_db="bundle exec rake 'neo4j:stop[development]'"
- alias stop_test_db="bundle exec rake 'neo4j:stop[test]'"
- alias run_rails="bundle exec rails s -b $LOCAL_IP -p 3000"
- alias refresh_test_db="RAILS_ENV=test be rake db:create_dev_data"
- alias refresh_dev_db="RAILS_ENV=dev be rake db:create_dev_data"
- alias test_console="rails c -e test"

## NEO4j

- export NEO4J_PWD="OPTIONAL".
- export DATA_SANS_MIGRATION="MATCH (n) WHERE
  NOT(n:Neo4j::Migrations::SchemaMigration) RETURN n LIMIT 25"

### CREATE VECTOR INDEX NEO4J > 5.15

`CREATE VECTOR INDEX`endorsement-embeddings`FOR (n: Endorsement) ON (n.embeddings)
OPTIONS {indexConfig: {
`vector.dimensions`: 384,
 `vector.similarity_function`: 'cosine'
}}

NOMIC
CREATE VECTOR INDEX`endorsement-embeddings`FOR (n: Endorsement) ON (n.embeddings)
OPTIONS {indexConfig: {
`vector.dimensions`: 768,
`vector.similarity_function`: 'cosine'
}}
`

## Applications Environment Variables
##### Java
`export JAVA_HOME=$(/usr/libexec/java_home -v 1.8.0)`

##### Ollama server 
`export OLLAMA_SERVER_ADDRESS="http://localhost:11434"`

##### defualt general purpose LLM for chats and completions:
`export LLM=llama3`

##### default embedding model for Ollama
`export EMBEDDING_MODEL="mxbai-embed-large"`

##### postgres connection string
`export DATABASE_URL="postgres://postgres:password@localhost/konmego_development"`


### DEPRECATED

export TWITTER_CONSUMER_KEY="<KEY>"

export TWITTER_CONSUMER_SECRET="<SECRET>"

export SECRET_KEY_BASE="<SECRET_KEY_BASE>"


