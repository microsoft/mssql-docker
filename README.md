# SQL Server in Docker

This GitHub repository aims to provide a centralized location for community engagement. In here you will find documentation, Dockerfiles and additional developer resources. 

**SQL Server in Docker** comes in two different flavors:
- [Linux-based containers](https://github.com/Microsoft/mssql-docker/tree/master/linux): This Docker image uses [SQL Server 2017 Developer Edition on Linux](https://docs.microsoft.com/en-us/sql/linux/) on top of an Ubuntu 16.04 base image. This is meant to be run on [Docker Engine](https://www.docker.com/products/overview) on its multiple platforms.  There are also Dockerfiles here for building [RHEL](linux/preview/RHEL/Dockerfile) & [CentOS](linux/preview/CentOS/Dockerfile) based images.
- ~~[Windows-based containers](https://github.com/Microsoft/mssql-docker/tree/master/windows)~~: (**These builds are now depricated and not recommended to use in production, but kept up for reference and archival purposes.**) These Docker images used SQL Server 2017 Express Edition and SQL Server 2017 Developer Edition. Both images are based on Windows Container technology and can only be run using [Docker Engine for Windows Containers](https://msdn.microsoft.com/en-us/virtualization/windowscontainers/docker/configure_docker_daemon).

Before choosing to run a SQL Server container for production use cases, please review our [support policy](https://support.microsoft.com/en-us/help/4047326/support-policy-for-microsoft-sql-server) for SQL Server Containers to ensure that you are running on a supported configuration.

**SQL Server Command Line Tools(sqlcmd,bcp)** are also available as a Docker Image. You can now deliver SQL Server management payload using this as a base image for your CI/CD scenarios. Check out the [mssql-tools Docker Image](https://hub.docker.com/r/microsoft/mssql-tools/) to get started.


Visit the [Microsoft Docker Hub page](https://hub.docker.com/u/microsoft) for more information and additional images.

## Documentation
- [Getting started guide for the SQL Server on Linux container](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker)
- [Best practices guide](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-docker)

## Take our survey

Let us know more about how you would like to use SQL containers by taking our [survey](https://www.surveymonkey.com/r/XXSY536).

## Issues

For any issues with the repo, please file under this GitHub project on the [Issues section](https://github.com/Microsoft/mssql-docker/issues).

If you require support with a production related issue, then please raise a support incident with Microsoft [here](https://support.microsoft.com/en-us/hub/4343728/support-for-business).

There is also a [Gitter channel for SQL Server in DevOps](https://gitter.im/Microsoft/mssql-devops?utm_source=share-link&utm_medium=link&utm_campaign=share-link) that you can join and discuss interesting topics with other container, SQL Server, and DevOps enthusiasts.

## Troubleshooting & Frequently Asked Questions

- When using the Windows Docker CLI you must use double quotes instead of single ticks for the environment variables, else the mssql-server-linux image won't find the `ACCEPT_EULA` or `SA_PASSWORD` variables which are required to start the container.

- The 'sa' password has a minimum complexity requirement (8 characters, uppercase, lowercase, alphanumerical and/or non-alphanumerical)

- Licensing for SQL Server in Docker: Regardless of where you run it - VM, Docker, physical, cloud, on prem - the licensing model is the same and it depends on which edition of SQL Server you are using. The Express and Developer Editions are free. Standard and Enterprise have a cost. More information here: [https://www.microsoft.com/en-us/sql-server/sql-server-2016-editions](https://www.microsoft.com/en-us/sql-server/sql-server-2016-editions)

## License

The Docker resource files for SQL Server are licensed under the MIT license.  See the [LICENSE file](LICENSE) for more details.
