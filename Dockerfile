FROM redmine:6.1 AS base

WORKDIR /usr/src/redmine

# COPY docker-entrypoint.sh /docker-entrypoint.sh

FROM base AS redmine-dss-pnrp

COPY ./ /usr/src/redmine/plugins/dss_pnrp

RUN bundle config unset deployment && bundle install --no-deployment
