<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>

SQL Server container images do not include Machine Learning Services to keep the image size down for typical use cases of SQL Server.  This Dockerfile provides an example of how to build a container image that does include ML Services.

# Usage

## Build
1. Git clone or download all these files and maintain the directory structure.
2. In the same directory as this readme.md file, run the following command
```
docker build -t mssql-server-mlservices .
```
> **Note:**
> mssql-server-mlservices is just a suggested name for the container image.  You can use a different name if you want to.

## Run
1. Once you have built the container image, you can run it by running the following command:
```
docker run -d -e MSSQL_PID=Developer -e ACCEPT_EULA=Y -e ACCEPT_EULA_ML=Y -e SA_PASSWORD=<some password> -v <some directory on the host OS>:/var/opt/mssql -p 1433:1433 mssql-server-mlservices
```
> **Note:**
> You can use any of the following values for MSSQL_PID:  Developer (free), Express (free), Enteprise (paid), Standard (paid).  If you are using a paid edition, please ensure that you have purchased a license.

> **Note:**
> Provide an SA_PASSWORD value that meets the [SQL Server password complexity policy](https://docs.microsoft.com/en-us/sql/relational-databases/security/password-policy?view=sql-server-2017).  Replace \<some password\> with your actual password.

> **Note:**
> Volume mounting using -v is optional.  **Be sure to use volume mounting if you are concerned with preserving the data if the container is ever deleted.**  Replace \<some directory on the host OS\> with an actual directory where you want to mount the database data and log files.  

> **Note:**
> Volume mounting does work on macOS right now.  ([Tracking issue](https://github.com/microsoft/mssql-docker/issues/12))

> **Note:**
> By setting the ACCEPT_EULA and ACCEPT_EULA environment variables values to "Y", you are accepting the licensing terms for SQL Server and Machine Learning Services.

2. Confirm that the container is running by running the following command:
```
docker ps -a
```

## Use
<button type="button" class="btn btn-primary" href="ConfigureAndTestMLServices.ipynb">Open Notebook in Azure Data Studio</button>  [Don't have Azure Data Studio yet?](https://docs.microsoft.com/en-us/sql/azure-data-studio/download) [Open Notebook](azuredatastudio://microsoft.notebook/open?url=https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fmssql-docker%2Fmaster%2Flinux%2Fpreview%2Fexamples%2Fmssql-mlservices%2FConfigureAndTestMLServices.ipynb)


<a class="btn btn-info" role="button" href="/ConfigureAndTestMLServices.ipynb">open me</a>

<!-- Place this tag where you want the button to render. -->
<a href="azuredatastudio://microsoft.notebook/open?url=https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fmssql-docker%2Fmaster%2Flinux%2Fpreview%2Fexamples%2Fmssql-mlservices%2FConfigureAndTestMLServices.ipynb" data-icon="octicon-cloud-download" aria-label="Download notebook">Open in Azure Data Studio</a>


1. Connect to Linux SQL Server in the container and enable external script execution by running the following T-SQL statement:
```
EXEC sp_configure  'external scripts enabled', 1
RECONFIGURE WITH OVERRIDE
```
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