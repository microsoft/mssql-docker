SQL Server container images do not include Machine Learning Services to keep the image size down for typical use cases of SQL Server.  This Dockerfile provides an example of how to build a container image that does include ML Services.
This sample includes Machine Learning Services including R and python - the resulting image is about 9GB.

# Usage

## Build
1. Git clone or download all these files and maintain the directory structure.
2. In the same directory as this readme file, run the following command
```
docker build -t mssql-server-mlservices .
```
> **Note:**
> mssql-server-mlservices is just a suggested name for the container image.  You can use a different name if you want to.

> **Note:**
> The Dockerfile does not install the mssql-tools (e.g. sqlcmd) - to add them to the dockerfile or install on the host, see https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility?view=sql-server-ver15

> **NOTE**
> The dockerfile uses the Ubuntu 16.04 base image and the matching SQL server repository for SQL server 2019
> in the "CU" version. See https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-change-repo for more info about available repository types (2017/2019 and preview, CU and GDR)

> **NOTE**
> According to the official documentation for SQL Server on Linux (at https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-linux-ver15),
> now also Ubuntu 18.04 is supported - also Docker for Windows is listed (but not which variant: WSL, LCOW, Hyper-V Moby, ... what a mess for _write once ship everywhere_)


## Run
1. Once you have built the container image, you can run it by running the following command:
```
docker run -d \
    -e MSSQL_PID=Developer \
    -e ACCEPT_EULA=Y \
    -e ACCEPT_EULA_ML=Y \
    -e MSSQL_SA_PASSWORD=<some password> \  
    -v <some directory on the host OS>:/var/opt/mssql \
    -p 1433:1433 \
    mssql-server-mlservices
```
> **Note:**
> For more configuration options, see https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-docker

> **Note:**
> You can use any of the following values for MSSQL_PID:  Developer (free), Express (free), Enteprise (paid), Standard (paid).  If you are using a paid edition, please ensure that you have purchased a license.

> **Note:**
> Provide an MSSQL_SA_PASSWORD value that meets the [SQL Server password complexity policy](https://docs.microsoft.com/en-us/sql/relational-databases/security/password-policy?view=sql-server-2017).  Replace \<some password\> with your actual password.

> **Note:**
> Volume mounting using -v is optional.  **Be sure to use volume mounting if you are concerned with preserving the data if the container is ever deleted.**  Replace \<some directory on the host OS\> with an actual directory where you want to mount the database data and log files.  

> **Note:**
> Volume mounting does work on macOS right now.  ([Tracking issue](https://github.com/microsoft/mssql-docker/issues/12))

> **Note:**
> By setting the ACCEPT_EULA and ACCEPT_EULA_ML environment variables values to "Y", you are accepting the licensing terms for SQL Server and Machine Learning Services.

2. Confirm that the container is running by running the following command:
```
docker ps -a
```

## Use
The repository contains an IPython notebook which can be used from Azure Data Studio (see https://docs.microsoft.com/en-us/sql/azure-data-studio). 

[Open Notebook](/linux/preview/examples/mssql-mlservices/ConfigureAndTestMLServices.ipynb)


1. Connect to Linux SQL Server in the container and enable external script execution by running the following T-SQL statement:
```
EXEC sp_configure  'external scripts enabled', 1
RECONFIGURE WITH OVERRIDE
```

> **NOTE**
> If running with sqlcmd, then add semikolons and the GO command after each line.

2. Verify ML Services is working by running the following simple R/Python sp_execute_external_script:
```
execute sp_execute_external_script 
@language = N'R',
@script = N'
print("Hello World!")
print(R.version)
print(Revo.version)
OutputDataSet <- InputDataSet', 
@input_data_1 = N'select 1'
go
```

```
execute sp_execute_external_script 
@language = N'Python',
@script = N'
import sys
print(sys.version)
print("Hello World!")
OutputDataSet = InputDataSet',
@input_data_1 = N'select 1'
go 
```
