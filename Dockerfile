FROM bitnami/redmine

WORKDIR /opt/bitnami/redmine/

RUN apt-get update && apt-get install build-essential default-libmysqlclient-dev libpq-dev libmagickwand-dev -y

COPY redmine_agile /opt/bitnami/redmine/plugins/redmine_agile

RUN bundle config unset deployment
RUN bundle install --no-deployment

RUN apt-get autoremove && apt-get clean
