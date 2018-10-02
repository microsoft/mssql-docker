# Exmple of creating a container image that will run as a user 'mssql' instead of root
# This is example is based on the official image from Microsoft and effectively just changes the user that SQL Server runs as

FROM microsoft/mssql-server-linux:latest

RUN mkdir /var/opt/mssql && \
    useradd -d /var/opt/mssql -c "Microsoft SQL Server user" mssql && \
    chown mssql:mssql /var/opt/mssql -R

USER mssql

ENV HOME=/var/opt/mssql \
    APP_HOME=/var/opt/mssql

CMD ["/opt/mssql/bin/sqlservr"]
