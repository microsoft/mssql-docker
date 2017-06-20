# mssql-agent-fts-ha-tools
# Maintainers: Microsoft Corporation (LuisBosquez and twright-msft on GitHub)
# GitRepo: https://github.com/Microsoft/mssql-docker

# Base OS layer: Latest Ubuntu LTS + mssql-server-linux (SQL Server engine + tools)
FROM microsoft/mssql-server-linux

#Install curl since it is needed to get repo config
# Get official Microsoft repository configuration
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y curl  && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server.list | tee /etc/apt/sources.list.d/mssql-server.list && \
    apt-get update

# Install optional packages.  Comment out the ones you don't need
RUN apt-get install -y mssql-server-agent
RUN apt-get install -y mssql-server-ha
RUN apt-get install -y mssql-server-fts

# Run SQL Server process
CMD /opt/mssql/bin/sqlservr