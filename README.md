# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

neo4j settings located in db neo4j[development,test]/conf/neo4j.conf folder
neo4j.yml config which controls rails connection must match the settings in the
neo4j.conf file
* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* env-local:
* 
export TWITTER_CONSUMER_KEY="AA8PG89dQlzJmqWpGhrcyHacC"
export TWITTER_CONSUMER_SECRET="lq4GwSjKY7L0aAUdtncExL6OqudIZhWCBxTqlIbVrqWnEpX4Rf"
export SECRET_KEY_BASE="55ddbe69b5e1cf8ae25011f404fc1a5a74c12433ad24eb1c09721b9ad8697c3362c20161825c90115a08202704bbe4062ea9cc7387cf755094d702c04b941cbb"
export NEO4J_PWD="cala5nj"
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
