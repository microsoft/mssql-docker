# SQL Server 2019 on RHEL 7 sample script
# This is a sample script shared to help create the SQL Server 2019 containers images based on RHEL 7
# This script can be modified to add other SQL Server components like polybase, Full text search, and others.
# Base OS layer: latest RHEL 7 latest image
FROM registry.access.redhat.com/rhel7:latest

## Adding the required repos for installing SQL Server, tools, and other dependent packages. 
RUN REPOLIST=rhel-7-server-rpms,packages-microsoft-com-mssql-server-2019,packages-microsoft-com-prod && \
    curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-2019.repo && \
    curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/7/prod.repo && \
    ACCEPT_EULA=Y yum -y install --disablerepo "*" --enablerepo ${REPOLIST} --setopt=tsflags=nodocs \
      mssql-server mssql-tools unixODBC-devel && \
    yum clean all

## Providing the required access to the mssql server folders
RUN mkdir -p -m 770 /var/opt/mssql && chown -R mssql. /var/opt/mssql

## Default SQL Server port
EXPOSE 1433

## Running SQL containers as non-root
USER mssql

## Start SQL server
CMD /opt/mssql/bin/sqlservr
