alias run_rails="bundle exec rails s -b $LOCAL_IP -p 3000"
alias refresh_test_db="RAILS_ENV=test be rake db:create_dev_data"
alias refresh_dev_db="RAILS_ENV=development be rake db:create_dev_data"
alias test_console="rails c -e test"