# [mssql-server-linux](https://hub.docker.com/r/microsoft/mssql-server-linux/) 
---
Full documentation can be found at the [SQL Server on Linux Docker image page](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-docker).

 [Microsoft SQL Server on Linux for Docker Engine](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-docker). Learn more about the latest release of SQL Server on Linux here: [SQL Server on Linux Documentation](https://docs.microsoft.com/en-us/sql/linux/).

###### Additional Microsoft SQL Server Docker Images
+ SQL Server for Windows Containers: [microsoft/mssql-server-windows](https://hub.docker.com/r/microsoft/mssql-server-windows/)
+ SQL Server Express for Windows Containers: [microsoft/mssql-server-windows-express](https://hub.docker.com/r/microsoft/mssql-server-windows-express/)

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
######  Start a mssql-server instance
> ``docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=yourStrong(!)Password' -p 1433:1433 -d microsoft/mssql-server-linux``

######  Connect to Microsoft SQL Server
There are no tools installed inside the container for now.  You can connect to the SQL Server instance from outside the container by using various command line and GUI tools on the host or remote computers.  See the [Connect and Query](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-connect-and-query-sqlcmd) topic in the SQL Server on Linux documentation.

######  Environment Variables

- ACCEPT_EULA confirms acceptance of the [End-User Licensing Agreement](http://go.microsoft.com/fwlink/?LinkId=746388).
- SA_PASSWORD is the system administrator (userid = 'sa') password used to connect to SQL Server once the container is running.

# User Feedback 
---
+ For issues with or questions about this image, please contact us through a [GitHub issue](https://github.com/Microsoft/sql-server-samples/issues). 

# Further Reading
---
+ [SQL Server on Linux for Docker documentation](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-docker)
+ [SQL Server - Developer Getting Started Tutorials](https://www.microsoft.com/en-us/sql-server/developer-get-started/?utm_source=DockerHub)