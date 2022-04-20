# SQL Server 2017 on RHEL 8 ubi Sample
# This is a sample script shared to help create the SQL Server 2017 containers images based on RHEL 8
# This script can be modified to add other SQL Server components like polybase, Full text search, and others.
# Base OS layer: latest RHEL 8 ubi image
FROM registry.access.redhat.com/ubi8:latest

# You need to ensure that the host where you are building this image has repos subscribed that are required to install the package dependencies, like python3, bzip2, and many more.
# Adding repositories and installing SQL Server and tools packages
RUN REPOLIST=rhel-8-for-x86_64-baseos-rpms,rhel-8-for-x86_64-appstream-rpms,packages-microsoft-com-mssql-server-2017,packages-microsoft-com-prod && \
    curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/8/mssql-server-2017.repo && \
    curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/8/prod.repo && \
    ACCEPT_EULA=Y yum -y install --disablerepo "*" --enablerepo ${REPOLIST} --setopt=tsflags=nodocs \
      mssql-server mssql-tools unixODBC-devel && \
    yum clean all

## Adding the required non-root mssql user and also giving access to the mssql server folders
RUN useradd -M -s /bin/bash -u 10001 -g 0 mssql
RUN mkdir -p -m 770 /var/opt/mssql && chown -R mssql. /var/opt/mssql

## Containers not to be run as root, so accessing it as mssql user.
USER mssql

# Default SQL Server TCP/Port
EXPOSE 1433

# Run SQL Server binary
CMD ["/opt/mssql/bin/sqlservr"]
