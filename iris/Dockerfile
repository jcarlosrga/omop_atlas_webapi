ARG IMAGE=intersystemsdc/irishealth-community:latest
FROM $IMAGE
USER root

WORKDIR /opt/irisbuild

ADD data.tar.gz data

COPY src src
COPY ddl ddl
COPY ddlMySQL ddlMySQL
COPY jdbc jdbc
COPY Installer.cls Installer.cls
COPY module.xml module.xml
COPY iris.script iris.script

ADD db/irisapp.tar.gz db/irisapp

RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild
USER ${ISC_PACKAGE_MGRUSER}

## prepare IRIS and FHIR, cache long operation
RUN iris start IRIS \
    && iris session IRIS < iris.script \
    && iris stop IRIS quietly

