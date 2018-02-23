# mssql-agent-fts-ha-tools
# Maintainers: Microsoft Corporation (twright-msft on GitHub)
# GitRepo: https://github.com/Microsoft/mssql-docker

# Base OS layer: Latest Ubuntu LTS
FROM ubuntu:16.04

#Install curl since it is needed to get repo config
# Get official Microsoft repository configuration
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y curl && \
    apt-get install apt-transport-https && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list | tee /etc/apt/sources.list.d/mssql-server.list && \
    apt-get update

# Install SQL Server which a prerequisite for the optional packages below.
RUN apt-get install -y mssql-server

# Install optional packages.  Comment out the ones you don't need
#RUN apt-get install -y mssql-server-agent - The agent is included in the mssql-server package starting from 2017 CU4 and beyond.
RUN apt-get install -y mssql-server-ha
RUN apt-get install -y mssql-server-fts

# Run SQL Server process
CMD /opt/mssql/bin/sqlservr
