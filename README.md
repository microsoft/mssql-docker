# SQL Server in Docker

This GitHub repository aims to provide a centralized location for community engagement. In here you will find documentation, Dockerfiles and additional developer resources. 

**SQL Server in Docker** comes in two different flavors:
- [Linux-based containers](https://github.com/Microsoft/mssql-docker/tree/master/linux): This Docker image uses [SQL Server 2017 Developer Edition on Linux](https://docs.microsoft.com/en-us/sql/linux/) on top of an Ubuntu 16.04 base image. This is meant to be run on [Docker Engine](https://www.docker.com/products/overview) on its multiple platforms.  There are also Dockerfiles here for building [RHEL](linux/preview/RHEL/Dockerfile) & [CentOS](linux/preview/CentOS/Dockerfile) based images.
- [Windows-based containers](https://github.com/Microsoft/mssql-docker/tree/master/windows): These Docker images use SQL Server 2017 Express Edition and SQL Server 2017 Developer Edition. Both images are based on Windows Container technology and can only be run using [Docker Engine for Windows Containers](https://msdn.microsoft.com/en-us/virtualization/windowscontainers/docker/configure_docker_daemon).

**SQL Server Command Line Tools(sqlcmd,bcp)** are also available as a Docker Image. You can now deliver SQL Server management payload using this as a base image for your CI/CD scenarios. Check out the [mssql-tools Docker Image](https://hub.docker.com/r/microsoft/mssql-tools/) to get started.


Visit the [Microsoft Docker Hub page](https://hub.docker.com/u/microsoft) for more information and additional images.

## Documentation
- [Getting started guide for the SQL Server on Linux container](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker)
- [Best practices guide](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-docker)

## Take our survey

Let us know more about how you would like to use SQL containers by taking our survey:

<a href="https://www.surveymonkey.com/r/XXSY536"><img style="float: right;"  height="67" width="156" src="https://meetsstorenew.blob.core.windows.net/contianerhd/survey.png?st=2017-02-17T22%3A03%3A00Z&se=2100-02-18T22%3A03%3A00Z&sp=rl&sv=2015-12-11&sr=b&sig=DJSFoihBptSvO%2BjvWzwpHecf8o5yfAbJoD2qW5oB8tc%3D"></a>

## Issues

For any issues, please file under this GitHub project on the [Issues section](https://github.com/Microsoft/mssql-docker/issues).

There is also a [Gitter channel for SQL Server in DevOps](https://gitter.im/Microsoft/mssql-devops?utm_source=share-link&utm_medium=link&utm_campaign=share-link) that you can join and discuss interesting topics with other container, SQL Server, and DevOps enthusiasts.

## Troubleshooting & Frequently Asked Questions

- "Unknown blob" error code: You are probably trying to run the Windows Containers-based Docker image on a Linux-based Docker Engine. If you want to continue running the Windows Container-based image, we recommend reading the following community article: [Run Linux and Windows Containers on Windows 10](https://stefanscherer.github.io/run-linux-and-windows-containers-on-windows-10/).

- When using the Windows Docker CLI you must use double quotes instead of single ticks for the environment variables, else the mssql-server-linux image won't find the `ACCEPT_EULA` or `SA_PASSWORD` variables which are required to start the container.

- The 'sa' password has a minimum complexity requirement (8 characters, uppercase, lowercase, alphanumerical and/or non-alphanumerical)

- Licensing for SQL Server in Docker: Regardless of where you run it - VM, Docker, physical, cloud, on prem - the licensing model is the same and it depends on which edition of SQL Server you are using. The Express and Developer Editions are free. Standard and Enterprise have a cost. More information here: [https://www.microsoft.com/en-us/sql-server/sql-server-2016-editions](https://www.microsoft.com/en-us/sql-server/sql-server-2016-editions)

## License

The Docker resource files for SQL Server are licensed under the MIT license.  See the [LICENSE file](LICENSE) for more details.

