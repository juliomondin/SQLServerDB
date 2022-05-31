FROM mcr.microsoft.com/mssql/server:2019-latest

# Default parameters
ENV ACCEPT_EULA Y
ENV TZ Europe/London
ENV SA_PASSWORD 5cREz5lh
# Add SQL CLI tools to PATH
ENV PATH "$PATH:/opt/mssql/bin:/opt/mssql-tools/bin"

# Prepare an automatic initialisation directory
USER root

RUN mkdir -p /var/opt/mssql-init &&\
    mkdir -p /var/opt/mssql-init/databases &&\
    chown mssql /var/opt/mssql-init

COPY ./sql/init.sh /var/opt/mssql-init/init.sh
COPY ./sql/legacy/databaseInit.sql /var/opt/mssql-init/databaseInit.sql
COPY ./sql/legacy/insert.sql /var/opt/mssql-init/insert.sql

RUN chown mssql /var/opt/mssql-init/init.sh &&\
    chmod +x /var/opt/mssql-init/init.sh

USER mssql

# SQL 2019 runs as a non-root user called mssql by default

EXPOSE 1433
ENTRYPOINT [ "/var/opt/mssql-init/init.sh" ]
