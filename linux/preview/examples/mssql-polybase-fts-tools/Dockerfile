# Base OS layer: Latest Ubuntu LTS
FROM mcr.microsoft.com/mssql/server:2019-latest
USER root
# Install prerequistes since it is needed to get repo config for SQL server
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*
RUN add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list)" && \
    apt-get install -y mssql-server-fts && \
    apt-get install -y mssql-server-polybase

EXPOSE 1433

USER mssql

# Run SQL Server process
CMD ["/opt/mssql/bin/sqlservr"]
