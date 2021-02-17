FROM bitnami/redmine

WORKDIR /opt/bitnami/redmine/

RUN apt-get update && apt-get install build-essential default-libmysqlclient-dev libpq-dev libmagickwand-dev -y

RUN mkdir /opt/bitnami/redmine/plugins/dss_pnrp
RUN git clone https://github.com/manuelchichi/dss-pnrp-redmine-plugin /opt/bitnami/redmine/plugins/dss_pnrp

RUN bundle config unset deployment
RUN bundle install --no-deployment

RUN apt-get autoremove && apt-get clean
