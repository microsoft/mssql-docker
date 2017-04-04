# mssql-server-linux
# Maintainers: Microsoft Corporation (LuisBosquez and twright-msft on GitHub)
# GitRepo: https://github.com/Microsoft/mssql-docker

# Base OS layer: Latest Ubuntu LTS.
FROM ubuntu:16.04

# For initialization scripts.
VOLUME /docker-entrypoint-initdb.d

# Default SQL Server TCP/Port.
EXPOSE 1433

# Copy all SQL Server runtime files from build drop into image.
COPY ./install /

# Copy initialization scripts.
COPY docker-entrypoint.sh /usr/local/bin/
COPY docker-entrypoint-initdb.sh /usr/local/bin/

# Run SQL Server process.
ENTRYPOINT ["docker-entrypoint.sh"]