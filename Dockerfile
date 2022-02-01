FROM redmine:4.2.3-passenger

WORKDIR /usr/src/redmine 

RUN apt-get update && apt-get install build-essential default-libmysqlclient-dev libpq-dev libmagickwand-dev -y \
    && mkdir -p /usr/src/redmine/plugins/dss_pnrpi \
    && git clone https://github.com/manuelchichi/dss-pnrp-redmine-plugin /usr/src/redmine/plugins/dss_pnrp \
    && bundle config unset deployment && bundle install --no-deployment \
    && apt-get autoremove && apt-get clean

COPY docker-entrypoint.sh /docker-entrypoint.sh
