FROM bitnami/redmine:4.2.0

WORKDIR /opt/bitnami/redmine/

RUN apt-get update && apt-get install build-essential default-libmysqlclient-dev libpq-dev libmagickwand-dev -y \
    && mkdir -p /bitnami/redmine/plugins/dss_pnrpi \
    && git clone https://github.com/manuelchichi/dss-pnrp-redmine-plugin /bitnami/redmine/plugins/dss_pnrp \
    && bundle config unset deployment && bundle install --no-deployment \
    && apt-get autoremove && apt-get clean
