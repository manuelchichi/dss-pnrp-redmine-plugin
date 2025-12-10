FROM redmine:6.1 AS base

WORKDIR /usr/src/redmine

FROM base AS redmine-dss-pnrp

COPY ./ /usr/src/redmine/plugins/dss_pnrp

RUN bundle config unset deployment && bundle install --no-deployment
