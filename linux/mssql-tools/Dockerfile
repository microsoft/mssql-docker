# SQL Server Command Line Tools
FROM ubuntu:16.04

LABEL maintainer="SQL Server Engineering Team"

# apt-get and system utilities
RUN apt-get update && apt-get install -y \
	curl apt-transport-https debconf-utils unzip \
    && rm -rf /var/lib/apt/lists/*

# adding custom MS repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

# install SQL Server drivers and tools
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql mssql-tools

# Install SQLPackage for Linux and make it executable
RUN wget -O /tmp/sqlpackage.zip https://go.microsoft.com/fwlink/?linkid=2113331 \
    && unzip -qq /tmp/sqlpackage.zip -d /opt/sqlpackage \
    && chmod +x /opt/sqlpackage/sqlpackage \
    && rm /tmp/sqlpackage.zip

# Add mssql-tools and sqlpackage paths
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin:/opt/sqlpackage"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"



RUN apt-get -y install locales
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8



CMD /bin/bash 



