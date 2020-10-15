FROM bitnami/redmine

WORKDIR /opt/bitnami/redmine/

RUN apt-get update && apt-get install build-essential default-libmysqlclient-dev libpq-dev libmagickwand-dev -y
RUN mkdir /opt/bitnami/redmine/plugins/dss_pnrp
ARG DUMMY=unknown
RUN DUMMY=${DUMMY} git clone https://github.com/Rockmaclu/dss-pnrp-redmine-plugin /opt/bitnami/redmine/plugins/dss_pnrp

RUN apt-get autoremove && apt-get clean
