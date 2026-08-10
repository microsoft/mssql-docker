# SQL Server in Docker

This GitHub repository aims to provide a centralized location for community engagement. In here you will find documentation, Dockerfiles and additional developer resources. 

**SQL Server in Docker** comes in two different flavors:
- [Linux-based containers](https://github.com/Microsoft/mssql-docker/tree/master/linux): This Docker image uses [SQL Server 2025 Developer Edition on Linux](https://docs.microsoft.com/en-us/sql/linux/) on top of an Ubuntu 24.04 base image. This is meant to be run on [Docker Engine](https://www.docker.com/products/overview) on its multiple platforms.  There are also Dockerfiles here for building [RHEL](linux/preview/RHEL/Dockerfile) & [CentOS](linux/preview/CentOS/Dockerfile) based images.
- [Windows-based containers](https://github.com/Microsoft/mssql-docker/tree/master/windows): These Docker images use SQL Server 2025 Express Edition and SQL Server 2025 Developer Edition. Both images are based on Windows Container technology and can only be run using [Docker Engine for Windows Containers](https://msdn.microsoft.com/en-us/virtualization/windowscontainers/docker/configure_docker_daemon).

Before choosing to run a SQL Server container for production use cases, please review our [support policy](https://support.microsoft.com/en-us/help/4047326/support-policy-for-microsoft-sql-server) for SQL Server Containers to ensure that you are running on a supported configuration.

**SQL Server Command Line Tools(sqlcmd,bcp)** are also available as a Docker Image. You can now deliver SQL Server management payload using this as a base image for your CI/CD scenarios. Check out the [mssql-tools Docker Image](https://hub.docker.com/r/microsoft/mssql-tools/) to get started.


Visit the [Microsoft Docker Hub page](https://hub.docker.com/u/microsoft) for more information and additional images.

## Documentation
- [Getting started guide for the SQL Server on Linux container](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker)
- [Best practices guide](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-docker)

## Take our survey

Let us know more about how you would like to use SQL containers by taking our [survey](https://forms.cloud.microsoft/r/kSdD5x0Que).

## Issues

For any issues with the repo, please file under this GitHub project on the [Issues section](https://github.com/Microsoft/mssql-docker/issues).

If you require support with a production related issue, then please raise a support incident with Microsoft [here](https://support.microsoft.com/en-us/hub/4343728/support-for-business).

There is also a [Gitter channel for SQL Server in DevOps](https://gitter.im/Microsoft/mssql-devops?utm_source=share-link&utm_medium=link&utm_campaign=share-link) that you can join and discuss interesting topics with other container, SQL Server, and DevOps enthusiasts.

## Troubleshooting & Frequently Asked Questions

- "Unknown blob" error code: This error usually indicates that you are attempting to run a Windows container image on a Linux container runtime. Verify that your image and container runtime use the same OS. If you need to run the Windows-based image, switch Docker to Windows Containers mode.

- When using the Windows Docker CLI you must use double quotes instead of single ticks for the environment variables, else the mssql-server-linux image won't find the `ACCEPT_EULA` or `SA_PASSWORD` variables which are required to start the container.

- The 'sa' password has a minimum complexity requirement (8 characters, uppercase, lowercase, alphanumerical and/or non-alphanumerical)

- Licensing for SQL Server in Docker: Regardless of where you run it - VM, Docker, physical, cloud, on prem - the licensing model is the same and it depends on which edition of SQL Server you are using. The Express and Developer Editions are free. Standard and Enterprise have a cost. More information here: [Editions and supported features of SQL Server 2025](https://learn.microsoft.com/en-us/sql/sql-server/editions-and-components-of-sql-server-2025?view=sql-server-ver17)

## License

The Docker resource files for SQL Server are licensed under the MIT license.  See the [LICENSE file](LICENSE) for more details.

