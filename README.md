# SQL Server in Docker

SQL Server in Docker comes in two different flavors:
    - [Linux-based containers](https://github.com/Microsoft/mssql-docker/tree/master/linux): This Docker image uses [SQL Server on Linux](https://docs.microsoft.com/en-us/sql/linux/) on top of an Ubuntu 16.04 base image. This is meant to be run on [Docker Engine](https://www.docker.com/products/overview) on its multiple platforms.
    - [Windows-based containers](https://github.com/Microsoft/mssql-docker/tree/master/windows): This Docker image is based on Windows Container technology and can only be run using [Docker Engine for Windows Containers](https://msdn.microsoft.com/en-us/virtualization/windowscontainers/docker/configure_docker_daemon).

## Troubleshooting & Frequently Asked Questions
- "Unknown blob" error code: You are probably trying to run the Windows Containers-based Docker image on a Linux-based Docker Engine. You can   

    
