# PHP Development Environment for SQL Server

This image provides an integrated development environment for PHP with connectivity to a remote SQL Server database. Learn more about [SQL Server on Linux](https://hub.docker.com/_/microsoft-mssql-server). To report issues or provide feedback, please file an issue in the [SQL Server in Docker GitHub Repository](https://github.com/Microsoft/mssql-docker).

### [Dockerfile](https://github.com/Microsoft/mssql-docker/blob/master/oss-drivers//msphpsql/Dockerfile)

The following components are included:
- Ubuntu 16.04 OS layer.
- Pre-configured PHP7.0 runtime environment.
- [sqlsrv](http://php.net/manual/en/book.sqlsrv.php) and [pdo_sqlsrv](http://php.net/manual/en/ref.pdo-sqlsrv.php) for SQL Server.
- A working PHP to SQL Server code sample.
- SQL Server command-line utilities (sqlcmd and bcp).
- Command-line text editor tools (nano and vim).

## Usage
To run an interactive bash session in this container simply run:

        docker run -it microsoft/msphpsql

The following optional environment variables can be provided to create the code sample:
- `$DB_HOST`: The IP address or hostname where the SQL Server instance is running.
- `$DB_USERNAME`: The database user in the SQL Server instance. 
- `$DB_PASSWORD`: The database user's password in the SQL Server instance. 

    **Note:** If you are running SQL Server in a Docker container as well, you can obtain the container's IP address using `docker inspect <containerID>`.

After passing the above environment variables Within the container, you can run the following commands:
- `php connect.php`: Execute the code sample to connect to SQL Server. The `connect.php` file will already have the database parameters.
- `sqlcmd -S $DB_HOST -U $DB_USERNAME -P $DB_PASSWORD`: This will run the command-line client for SQL Server where you can execute T-SQL statements against it.

# User Feedback 
---

+ For issues with or questions about this image, please contact us through a [GitHub issue](https://github.com/Microsoft/mssql-docker/issues). 

# Further Reading
---

+ [SQL Server on Linux for Docker documentation](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-docker)
+ [SQL Server - Developer Getting Started Tutorials](https://www.microsoft.com/en-us/sql-server/developer-get-started/?utm_source=DockerHub)
+ [SQL Server Docker GitHub Repository](https://github.com/Microsoft/mssql-docker)
