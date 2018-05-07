FROM ubuntu:16.04

# apt-get update and install required utilities
RUN apt-get update && apt-get install -y \
    curl apt-utils apt-transport-https debconf-utils gcc build-essential g++-5\
    && rm -rf /var/lib/apt/lists/*

# adding custom MS repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Update the list of products
RUN apt-get update

# Install mssql-cli
RUN apt-get install mssql-cli -y

CMD ["/bin/bash", "-c", "sleep infinity"]