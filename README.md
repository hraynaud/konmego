# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

neo4j settings located in db neo4j[development,test]/conf/neo4j.conf folder
neo4j.yml config which controls rails connection must match the settings in the
neo4j.conf file.
DO NOT SET NEO4J_HOME OR URL unless you are using a stand_alone_instance of
NEO4J and not the emebedded one that caomes with neo4jrb. Otherwise all
environments test and development will look for NEO4J db in NEO4J_HOME directory
* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* env-local:
* 
export TWITTER_CONSUMER_KEY="<KEY>"
export TWITTER_CONSUMER_SECRET="<SECRET>"
export SECRET_KEY_BASE="<SECRET_KEY_BASE>"
export NEO4J_PWD="OPTIONAL"
export DATA_SANS_MIGRATION="MATCH (n) WHERE
NOT(n:Neo4j::Migrations::SchemaMigration) RETURN n LIMIT 25"
alias start_dev_db="bundle exec rake 'neo4j:start[development]'"
alias start_test_db="bundle exec rake 'neo4j:start[test]'"
alias stop_dev_db="bundle exec rake 'neo4j:stop[development]'"
alias stop_test_db="bundle exec rake 'neo4j:stop[test]'"
alias run_rails="bundle exec rails s -b $LOCAL_IP -p 3000"
alias refresh_test_db="RAILS_ENV=test be rake db:create_dev_data"
alias refresh_dev_db="RAILS_ENV=dev be rake db:create_dev_data"
alias test_console="rails c -e test" ...
