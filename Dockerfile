FROM redmine:4.2.3-passenger as base

WORKDIR /usr/src/redmine

COPY docker-entrypoint.sh /docker-entrypoint.sh

FROM base as redmine-dss-pnrp

COPY ./ /usr/src/redmine/plugins/dss_pnrp

RUN bundle config unset deployment && bundle install --no-deployment
