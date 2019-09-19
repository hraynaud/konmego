export LOCAL_IP=`ifconfig en0 | awk '$1 == "inet" {print $2}'` ; bundle exec rails s -b $LOCAL_IP -p 3000

