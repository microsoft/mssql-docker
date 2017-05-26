# SQL Server in Docker

[![Join the chat at https://gitter.im/Microsoft/mssql-docker](https://badges.gitter.im/Microsoft/mssql-docker.svg)](https://gitter.im/Microsoft/mssql-docker?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This GitHub repository aims to provide a centralized location for community engagement. In here you will find documentation, Dockerfiles and additional developer resources. 

SQL Server in Docker comes in two different flavors:
- [Linux-based containers](https://github.com/Microsoft/mssql-docker/tree/master/linux): This Docker image uses [SQL Server on Linux](https://docs.microsoft.com/en-us/sql/linux/) on top of an Ubuntu 16.04 base image. This is meant to be run on [Docker Engine](https://www.docker.com/products/overview) on its multiple platforms.  There is also a [Dockerfile](https://github.com/Microsoft/mssql-docker/blob/master/linux/preview/RHEL/Dockerfile) here that you can use to build a RHEL-based image.
- [Windows-based containers](https://github.com/Microsoft/mssql-docker/tree/master/windows): These Docker images use SQL Server 2016 SP1 Express Edition, SQL Server 2016 SP1 Developer Edition and SQL Server 2017 Evaluation Edition. All three images are based on Windows Container technology and can only be run using [Docker Engine for Windows Containers](https://msdn.microsoft.com/en-us/virtualization/windowscontainers/docker/configure_docker_daemon).

Visit the [Microsoft Docker Hub page](https://hub.docker.com/u/microsoft) for more information and additional images.

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

