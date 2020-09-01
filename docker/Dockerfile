FROM bitnami/redmine

WORKDIR /opt/bitnami/redmine/

COPY .. /opt/bitnami/redmine/plugins/dss-pnrp

RUN bundle config unset deployment
RUN bundle install --no-deployment
