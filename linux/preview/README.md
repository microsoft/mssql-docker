# [mssql-server-linux](https://hub.docker.com/r/microsoft/mssql-server-linux/) 
Full documentation can be found at the [SQL Server on Linux Docker image page](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-docker).

 [Microsoft SQL Server on Linux for Docker Engine](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-docker). Learn more about the latest release of SQL Server on Linux here: [SQL Server on Linux Documentation](https://docs.microsoft.com/en-us/sql/linux/).

###### Additional Microsoft SQL Server Docker Images
+ Latest *Pre-Release* Version of SQL Server *Evaluation* Edition for Windows Containers: [microsoft/mssql-server-windows](https://hub.docker.com/r/microsoft/mssql-server-windows/)
+ Latest *Released* Version of SQL Server *Developer* Edition for Windows Containers: [microsoft/mssql-server-windows-developer](https://hub.docker.com/r/microsoft/mssql-server-windows-developer/)
+ Latest *Released Version* of SQL Server *Express* Edition for Windows Containers: [microsoft/mssql-server-windows-express](https://hub.docker.com/r/microsoft/mssql-server-windows-express/)

**Note:** Developer Edition is a full-featured version of SQL Server without resource limits, but can only be used in dev/test.  Express Edition is a resouce-limited edition of SQL Server that can be used in production.
Get more information on [SQL Server Editions](https://www.microsoft.com/en-us/sql-server/sql-server-editions).

## Requirements
---
- This image requires Docker Engine 1.8+ in any of [their supported platforms](https://www.docker.com/products/overview).
- At least 3.25 GB of RAM. Make sure to assign enough memory to the Docker VM if you're running on Docker for [Mac](https://docs.docker.com/docker-for-mac/#/general) or [Windows](https://docs.docker.com/docker-for-windows/#/advanced).
- Requires the following environment flags
    - ACCEPT_EULA=Y
    - SA_PASSWORD=<your_strong_password>
- A strong system administrator (SA) password: At least 8 characters including uppercase, lowercase letters, base-10 digits and/or non-alphanumeric symbols.

## How to use this image
---
######  Start a mssql-server instance
> ``docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=yourStrong(!)Password' -p 1433:1433 -d microsoft/mssql-server-linux``

######  Connect to Microsoft SQL Server
There are no tools installed inside the container for now.  You can connect to the SQL Server instance from outside the container by using various command line and GUI tools on the host or remote computers.  See the [Connect and Query](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-connect-and-query-sqlcmd) topic in the SQL Server on Linux documentation.

######  Environment Variables

- ACCEPT_EULA confirms acceptance of the [End-User Licensing Agreement](http://go.microsoft.com/fwlink/?LinkId=746388).
- SA_PASSWORD is the database system administrator (userid = 'sa') password used to connect to SQL Server once the container is running.

## Current Limitations
---
- Mapping volumes to the host using 'docker run -v' is not supported for Docker for Mac. You can use [data volume containers](https://docs.docker.com/engine/tutorials/dockervolumes/#/creating-and-mounting-a-data-volume-container) instead for data file persistence.  Resolving this limitation is tracked as issue [#12](https://github.com/Microsoft/mssql-docker/issues/12).

## User Feedback 
---
+ For issues with or questions about this image, please contact us through a [GitHub issue](https://github.com/Microsoft/mssql-docker/issues). 

## Frequently asked questions 
---
- **How do I map a volume using Docker for Windows?** Make sure to enable [shared drives in the settings menu](https://docs.docker.com/docker-for-windows/#shared-drives). After that, you can map a volume specifying the **Windows path:Linux path**. The following is an example of a command to map a Windows folder to the data directory in the container:

> ``docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=yourStrong(!)Password' -p 1433:1433 -v C:\MyWindowsVolume:/var/opt/mssql -d microsoft/mssql-server-linux``


## Further Reading
---
+ [SQL Server on Linux for Docker documentation](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-docker)
+ [SQL Server - Developer Getting Started Tutorials](https://www.microsoft.com/en-us/sql-server/developer-get-started/?utm_source=DockerHub)
