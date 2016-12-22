# mssql-server-2016-sp1-express-windows
This Dockerfile helps developers to get started using SQL Server 2016 SP1 Express in Windows Containers. The file downloads and installs SQL Server 2016 SP1 Express with the default setup parameters.

### Contents

[About this sample](#about-this-sample)<br/>
[Before you begin](#before-you-begin)<br/>
[Run this sample](#run-this-sample)<br/>
[Sample details](#sample-details)<br/>
[Disclaimers](#disclaimers)<br/>
[Related links](#related-links)<br/>

<a name=about-this-sample></a>

## About this sample

1. **Applies to:** SQL Server 2016 SP1 Express, Windows Server 2016
5. **Authors:** Perry Skountrianos [perrysk-msft]

<a name=before-you-begin></a>

## Before you begin

To run this sample, you need the following prerequisites.

**Software prerequisites:**

You can run the container with the following command.
(Note the you'll need Windows Server 2016 or Windows 10)

````
docker run -d -p 1433:1433 -v C:/temp/:C:/temp/ -e sa_password=<YOUR SA PASSWORD> -e ACCEPT_EULA=Y -e attach_dbs="<DB-JSON-CONFIG>" microsoft/mssql-server-windows-express
````

- **-p HostPort:containerPort** is for port-mapping a container network port to a host port.
- **-v HostPath:containerPath** is for mounting a folder from the host inside the container.

  This can be used for saving database outside of the container.

- **-it** can be used to show the verbose output of the SQL startup script.

  Use this to debug the container in case of issues.

<a name=run-this-sample></a>

## Run this sample

The image provides two environment variables to optionally set: </br>
- **accepot_eula**: Confirms acceptance of the end user licensing agreement found [here](http://go.microsoft.com/fwlink/?LinkId=746388)
- **sa_password**: Sets the sa password and enables the sa login
- **attach_dbs**: The configuration for attaching custom DBs (.mdf, .ldf files).

  This should be a JSON string, in the following format (note the use of SINGLE quotes!)
  ```
  [
	{
		'dbName': 'MaxDb',
		'dbFiles': ['C:\\temp\\maxtest.mdf',
		'C:\\temp\\maxtest_log.ldf']
	},
	{
		'dbName': 'PerryDb',
		'dbFiles': ['C:\\temp\\perrytest.mdf',
		'C:\\temp\\perrytest_log.ldf']
	}
  ]
  ```

  This is an array of databases, which can have zero to N databases.

  Each consisting of:
  - **dbName**: The name of the database
  - **dbFiles**: An array of one or many absolute paths to the .MDF and .LDF files.

	**Note:**
	The path has double backslashes for escaping!
	The path refers to files **within the container**. So make sure to include them in the image or mount them via **-v**!


This example shows all parameters in action:
```
docker run -d -p 1433:1433 -v C:/temp/:C:/temp/ -e sa_password=<YOUR SA PASSWORD> -e ACCEPT_EULA=Y -e attach_dbs="[{'dbName':'SampleDB','dbFiles':['C:\\temp\\sampledb.mdf','C:\\temp\\sampledb_log.
ldf']}]" microsoft/mssql-server-windows-express
```

<a name=sample-details></a>

## Sample details

The Dockerfile downloads and installs SQL Server 2016 Express with the following default setup parameters that could be changed (if needed) after the image is installed.
- Collation: SQL_Latin1_General_CP1_CI_AS
- SQL Instance Name: SQLEXPRESS
- Root Directory: C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL
- Language: English (United Stated)

<a name=disclaimers></a>

## Disclaimers
The code included in this sample is not intended to be a set of best practices on how to build scalable enterprise grade applications. This is beyond the scope of this quick start sample.

<a name=related-links></a>

## Related Links
<!-- Links to more articles. Remember to delete "en-us" from the link path. -->

For more information, see these articles:
- [Windows Containers] (https://msdn.microsoft.com/en-us/virtualization/windowscontainers/about/about_overview)
- [Windows-based containers: Modern app development with enterprise-grade control] (https://www.youtube.com/watch?v=Ryx3o0rD5lY&feature=youtu.be)
- [Windows Containers: What, Why and How] (https://channel9.msdn.com/Events/Build/2015/2-704)
- [SQL Server in Windows Containers] (https://blogs.msdn.microsoft.com/sqlserverstorageengine/2016/03/21/sql-server-in-windows-containers/#comments)
