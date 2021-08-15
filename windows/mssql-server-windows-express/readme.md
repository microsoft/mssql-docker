## Note: The SQL Server Express on Windows image is not supported for production use. If you have a need to use SQL Server on Windows containers in production, please sign up for the Early Adoption Preview at https://aka.ms/sqleap

# mssql-server-windows-express
This Dockerfile helps developers to get started using SQL Server Express in Windows Containers. The file downloads and installs SQL Server Express with the default setup parameters.

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
docker run -d -p 1433:1433 -v C:/temp/:C:/temp/ -e sa_password=<YOUR SA PASSWORD> -e ACCEPT_EULA=Y -e attach_dbs="<DB-JSON-CONFIG>" -e restore_dbs="<REST-DB-JSON-CONFIG>" -e base_db_folder=<DEST_REST_PATH> microsoft/mssql-server-windows-express
````

- **-p HostPort:containerPort** is for port-mapping a container network port to a host port.
- **-v HostPath:containerPath** is for mounting a folder from the host inside the container.

  This can be used for saving database outside of the container.

- **-it** can be used to show the verbose output of the SQL startup script.

  Use this to debug the container in case of issues.

<a name=run-this-sample></a>

## Run this sample

The image provides two environment variables to optionally set: </br>
- **accept_eula**: Confirms acceptance of the end user licensing agreement found [here](http://go.microsoft.com/fwlink/?LinkId=746388)
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

- **restore_dbs**: The configuration to restore custom DB backups (.bak files).

This should be a JSON string, in the following format (note the use of SINGLE quotes!)
  ```
  [
	{
		'dbName': 'RestoredDbNo1',
		'bckFile': 'C:\\temp\\DbToRestoreNo1.bak'
	},
	{
		'dbName': 'RestoredDbNo2',
		'bckFile': 'C:\\temp\\DbToRestoreNo2.bak'
	}
  ]
  ```

  This is an array of database backups, which can have zero to N database backup files.

  Each consisting of:
  - **dbName**: The name of the restored database.
  - **bckFile**: Absolute path to the .BAK file.

	**Note:**
	The path has double backslashes for escaping!
	The path refers to files **within the container**. So make sure to include them in the image or mount them via **-v**!

- **base_db_folder**: This parameter is necessary when **restore_dbs** is being provided. It indicates what destination master path will be used for restored database files. In the master path will be automatically created *DATA* folder and all databases will be actually placed here). In case of any restart of the container the data files from the folder will be attached automatically at first and then will restarted also the restoration process but this will skip all databases attached automatically before (anyone won\`t be replaced).

	**Note:**
	You can choose two different approaches here:
	- You can point into any *unmapped* folder. In this case the data will be persistent between every restart of the container but once killed you will lose all DB changes since the backup was restored.
	- You can point into any *mapped*/*mounted* folder via **-v** parameter. In this case the data will be persistent also in the case the container will be killed and created and started from scratch.

This example shows all parameters in action:
```
docker run -d -p 1433:1433 -v C:/temp/:C:/temp/ -e sa_password=<YOUR SA PASSWORD> -e ACCEPT_EULA=Y -e attach_dbs="[{'dbName':'SampleDB','dbFiles':['C:\\temp\\sampledb.mdf','C:\\temp\\sampledb_log.
ldf']}]" -e restore_dbs="[{'dbName':'RestoredDb','bckFile':'C:\\temp\\DbToRestore.bak'}]" -e base_db_folder="C:\\DB\\" "microsoft/mssql-server-windows-express
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
- [Windows Containers](https://msdn.microsoft.com/en-us/virtualization/windowscontainers/about/about_overview)
- [Windows-based containers: Modern app development with enterprise-grade control](https://www.youtube.com/watch?v=Ryx3o0rD5lY&feature=youtu.be)
- [Windows Containers: What, Why and How](https://channel9.msdn.com/Events/Build/2015/2-704)
- [SQL Server in Windows Containers](https://blogs.msdn.microsoft.com/sqlserverstorageengine/2016/03/21/sql-server-in-windows-containers/#comments)
