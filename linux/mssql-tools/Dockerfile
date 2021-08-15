# SQL Server Command Line Tools
FROM ubuntu:16.04

LABEL maintainer="SQL Server Engineering Team"

# Disable interactive installer
ENV DEBIAN_FRONTEND=noninteractive

# Install system utilities
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
            curl ca-certificates apt-transport-https debconf-utils locales \
    && rm -rf /var/lib/apt/lists/*

# Add Microsoft ubuntu repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Install SQL Server drivers and tools
RUN apt-get update \
    && ACCEPT_EULA=Y apt-get install --no-install-recommends -y \
            msodbcsql mssql-tools \
    && rm -rf /var/lib/apt/lists/*

# Setup PATH
ENV PATH="${PATH}:/opt/mssql-tools/bin"

# Setup locales
RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

CMD ["/bin/bash"]
