# List of files

- `Dockerfile` - main template file
- `README.md`  - Instruction to build the image, start a container and test out PolyBase feature.

# How to build, run, validate the PolyBase docker image

1. Download the Dockerfile to your computer.
2. Build the PolyBase docker image.
   - Change to the directory that conttains the downloaded `Dockerfile`
   - Run  `docker build` command to build the image.
     - E.g. `docker build -t mssql-polybase-preview . `

3. Start SQL Server with PolyBase feature.
   - Use `docker run` command to run /opt/mssql/bin/sqlservr in an isolated container.
   - On bash shell (Linux/macOS/Windows GitBash):
     - `$ docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=YourStrong!Passw0rd' -p 1433:1433 -d mssql-polybase-preview`
   - On elevated PowerShell command prompt:
     - `PS> docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourStrong!Passw0rd" -p 1433:1433 -d mssql-polybase-preview`

4. Enable PolyBase feature.
   - After SQL Server is started with `docker run` command, PolyBase must be enabled to access its features.
   - To enable PolyBase, connect to the SQL Server instance and execute the below T-SQL statements.
     - `exec sp_configure @configname = 'polybase enabled', @configvalue = 1;`
     - `RECONFIGURE;`

5. Validate if PolyBase is working.
   - After PolyBase feature is enabled, One can run below sample sanity statements to check if PolyBase queries are working.

        ```
            create database PolyTestDb
            go

            use PolyTestDb
            go

            CREATE TABLE T1 (column1 nvarchar(50))
            GO

            INSERT INTO T1 values ('Hello PolyBase!')
            GO

            CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'YourStrong!Master!Passw0rd!'
            GO

            CREATE DATABASE SCOPED CREDENTIAL SaCredential WITH IDENTITY = 'sa', Secret = 'YourStrong!Passw0rd'
            GO

            CREATE EXTERNAL DATA SOURCE loopback_data_src WITH (LOCATION = 'sqlserver://127.0.0.1', CREDENTIAL = SaCredential)
            GO

            CREATE EXTERNAL TABLE T1_external (column1 nvarchar(50))  with (location='PolyTestDb..T1', DATA_SOURCE=loopback_data_src)
            GO

            select * from T1_external
            GO
        ```
6. Learn more about PolyBase.
   - [PolyBase documentation](https://docs.microsoft.com/en-us/sql/relational-databases/polybase/polybase-guide?view=sql-server-ver15)
  
