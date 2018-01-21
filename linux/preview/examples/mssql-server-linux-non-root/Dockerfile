FROM microsoft/mssql-server-linux:latest

RUN mkdir /var/opt/mssql && \
    useradd -d /var/opt/mssql -c "Microsoft SQL Server user" mssql && \
    chown mssql:mssql /opt/mssql -R && \
    chown mssql:mssql /var/opt/mssql -R

USER mssql

ENV HOME=/var/opt/mssql
ENV APP_HOME=/var/opt/mssql

CMD /opt/mssql/bin/sqlservr