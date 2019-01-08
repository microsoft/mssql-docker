# How to build a SQL Server on openSUSE container image

**Steps to building SQL Server on openSUSE container image**

1.	[optional] Customize the mssql.conf file. Example mssql.conf entries can be found here: https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-mssql-conf?view=sql-server-2017#mssql-conf-format 

2.	Build the docker image. 
    ```
    docker build . -t mssql-opensuse
    ```
3. Run the docker image. 
    ```
    sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=<YourStrong!Passw0rd>' \
   -p 1433:1433 --name sql1 \
   -d mssql-opensuse
    ```
