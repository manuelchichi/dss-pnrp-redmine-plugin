docker build --build-arg DUMMY=`date +%s` . -t redmine-dss-pnrp:0.0.1 

docker-compose down

docker-compose up -d
