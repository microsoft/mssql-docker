# Introduction
There are five Linux-based Docker container images documented here:
* A representation of the actual [Dockerfile](Ubuntu/Dockerfile) that is used by Microsoft to build the Ubuntu-based image [mssql-server-linux](https://hub.docker.com/r/microsoft/mssql-server-linux/)  which is available at Docker Hub.
* A [Dockerfile](CentOS/Dockerfile) for building a CentOS-based image on your own
* A [Dockerfile](RHEL/Dockerfile) for building a RHEL-based image on your own
* A [Dockerfile](SLES/dockerfile) for building a SLES-based image on your own
* A [Dockerfile](openSUSE/dockerfile) for building an openSUSE-based image on your own

Full documentation can be found at the [SQL Server on Linux Docker image page](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-docker).

Learn more about the latest release of SQL Server on Linux here: [SQL Server on Linux Documentation](https://docs.microsoft.com/en-us/sql/linux/).

# mssql-server-linux

This Ubuntu-based image is built and maintened by Microsoft, and published on [Docker Hub](https://hub.docker.com/r/microsoft/mssql-server-linux/).

# mssql-server-centos

## To build a CentOS-based image
To build an image locally on your Docker host follow these steps:
```shell
$ cd linux/preview/CentOS
$ make
$ make test
$ make run
```

# mssql-server-rhel
There is a [Dockerfile](RHEL/Dockerfile) on this project published for those that would like to build their own image based on the [official Red Hat Enterprise Linux 7 image](https://access.redhat.com/containers/#/registry.access.redhat.com/rhel7/rhel).

## Prerequisites for building a RHEL-based image
* You will need access to the [Red Hat Container Catalog](https://access.redhat.com/containers) via a Red Hat subscription.
* You will need to login to the Red Hat Container Catalog using docker login. [More info](https://access.redhat.com/articles/2834301)
* You will also need to provide your Red Hat subscription credentials in the Dockerfile before you build.
* You will also need to build the image yourself using Docker's command line tool '[docker](https://docs.docker.com/engine/reference/commandline/cli/)'.

## To build a RHEL-based image
To build an image locally on your Docker host follow these steps:
```shell
$ cd linux/preview/RHEL
$ make
$ make test
$ make run
```

# Requirements
---
- This image requires Docker Engine 1.8+ in any of [their supported platforms](https://www.docker.com/products/overview).
- At least 3.25 GB of RAM. Make sure to assign enough memory to the Docker VM if you're running on Docker for [Mac](https://docs.docker.com/docker-for-mac/#/general) or [Windows](https://docs.docker.com/docker-for-windows/#/advanced).
- Requires the following environment flags
    - ACCEPT_EULA=Y
    - SA_PASSWORD=<your_strong_password>
- A strong system administrator (SA) password: At least 8 characters including uppercase, lowercase letters, base-10 digits and/or non-alphanumeric symbols.

# How to use this image
---
##  Start a mssql-server instance
> ``docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=yourStrong(!)Password' -p 1433:1433 -d microsoft/mssql-server-linux``

##  Connect to Microsoft SQL Server
Starting with the CTP 1.4 (March 17, 2017) release the mssql-tools package including sqlcmd, bcp are included in the image.  You can connect to the SQL Server using the sqlcmd tool inside of the container by using the following command on the host:
```
docker exec -it <container_id|container_name> /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P <your_password>
```
You can also use the tools in an entrypoint.sh script to do things like create databases or logins, attach databases, import data, or other setup tasks.  See this example of [using an entrypoint.sh script to create a database and schema and bcp in some data](https://github.com/twright-msft/mssql-node-docker-demo-app).

You can connect to the SQL Server instance in the container from outside the container by using various command line and GUI tools on the host or remote computers.  See the [Connect and Query](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-connect-and-query-sqlcmd) topic in the SQL Server on Linux documentation.

## Environment variables

- ACCEPT_EULA confirms acceptance of the [End-User Licensing Agreement](http://go.microsoft.com/fwlink/?LinkId=746388).
- SA_PASSWORD is the database system administrator (userid = 'sa') password used to connect to SQL Server once the container is running.

Additional, optional environment variables are documented in the [product documentation](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-environment-variables).


# Current limitations
---
- Mapping volumes to the host using 'docker run -v' is not supported for Docker for Mac. You can use [data volume containers](https://docs.docker.com/engine/tutorials/dockervolumes/#/creating-and-mounting-a-data-volume-container) instead for data file persistence.  Resolving this limitation is tracked as issue [#12](https://github.com/Microsoft/mssql-docker/issues/12).

# Feedback 
---
+ For issues with or questions about these images or SQL Server on containers in general, please contact us through a [GitHub issue](https://github.com/Microsoft/mssql-docker/issues).
+ This is not an official support channel. If you require support with SQL Server, please contact Microsoft Support through the standard channels.

# Frequently asked questions 
---
- **How do I map a volume using Docker for Windows?** Make sure to enable [shared drives in the settings menu](https://docs.docker.com/docker-for-windows/#shared-drives). After that, you can map a volume specifying the **Windows path:Linux path**. The following is an example of a command to map a Windows folder to the data directory in the container:

> ``docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=yourStrong(!)Password' -p 1433:1433 -v C:\MyWindowsVolume:/var/opt/mssql -d microsoft/mssql-server-linux``

# Further reading
---
+ [SQL Server on Linux for Docker documentation](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-docker)
+ [SQL Server - Developer Getting Started Tutorials](https://www.microsoft.com/en-us/sql-server/developer-get-started/?utm_source=DockerHub)

# Additional Microsoft SQL Server Docker images
+ Latest *Pre-Release* Version of SQL Server *Evaluation* Edition for Windows Containers: [microsoft/mssql-server-windows](https://hub.docker.com/r/microsoft/mssql-server-windows/)
+ Latest *Released* Version of SQL Server *Developer* Edition for Windows Containers: [microsoft/mssql-server-windows-developer](https://hub.docker.com/r/microsoft/mssql-server-windows-developer/)
+ Latest *Released Version* of SQL Server *Express* Edition for Windows Containers: [microsoft/mssql-server-windows-express](https://hub.docker.com/r/microsoft/mssql-server-windows-express/)

**Note:** Developer Edition is a full-featured version of SQL Server without resource limits, but can only be used in dev/test.  Express Edition is a resource-limited edition of SQL Server that can be used in production.
Get more information on [SQL Server Editions](https://www.microsoft.com/en-us/sql-server/sql-server-editions).
