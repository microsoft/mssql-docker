# List of files

- `Dockerfile` - main template file
- `./overlay/tmp/install.sh` - helper file to install mssql-server, mssql-server-extensibility and mssql-mlservices R and python.
- `./overlay/tmp/supervisord.conf` - config file to start mssql-server and launchpad services with supervisor.
- `build.sh` - script to build mssql-server-mlservices docker image.
- `run.sh` - script to start docker container.

# Usage

1. Download all these files and maintain the dir structure.
2. Run the following script to build the image:
```
./build.sh
```
> Note:
> By default, both R and Python Services are installed into the image. If you just want to install R Services, edit `./overlay/tmp/install.sh` and set MLSERVICES_PKGS="mssql-mlservices-packages-r" in the script. If you just want to install Python Services, set MLSERVICES_PKGS="mssql-mlservices-packages-py".
3. Edit `run.sh` script to set variables MSSQL_PID, ACCEPT_EULA, ACCEPT_EULA_ML and PATH_TO_MSSQL. Make sure the folder specified by PATH_TO_MSSQL does exist. If not, create one. Example configuration to be included in the run.sh file:
```
MSSQL_PID='Developer'
ACCEPT_EULA='Y'
ACCEPT_EULA_ML='Y'
PATH_TO_MSSQL='/home/john/mssql/'
```

4. Run the the following script to start the container.
```
./run.sh
```
5. Connect to Linux SQL Server in the container and enable the external script by running the following TSQL statement:
```
EXEC sp_configure  'external scripts enabled', 1
RECONFIGURE WITH OVERRIDE
```
6. Verify ML Services working by running the following simple R/Python sp_execute_external_script:
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
