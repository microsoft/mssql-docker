# List of files

- `Dockerfile` - main template file
- `./overlay/tmp/install.sh` - helper file to install mssql-server, mssql-server-extensibility and mssql-mlservices R and python.
- `./overlay/tmp/supervisord.conf` - config file to start mssql-server and launchpad services with supervisor.
- `build.sh` - script to build mssql-server-mlservices docker image.
- `run.sh` - script to start docker container.

# Usage

1. Download all these files and maintain the dir structure.
2. Run the script `./build.sh` to build the image. By default, both R and Python Services are installed into the image. If you just want to install R Services, edit `./overlay/tmp/install.sh` and set MLSERVICES_PKGS="mssql-mlservices-packages-r" in the script. If you just want to install Python Services, set MLSERVICES_PKGS="mssql-mlservices-packages-py".
3. Edit `run.sh` script to set variables MSSQL_PID, ACCEPT_EULA, ACCEPT_EULA_ML and PATH_TO_MSSQL. Make sure the folder specified by PATH_TO_MSSQL does exist. If not, create one.
4. Run the script `./run.sh` to start the container.
5. Connect to Linux SQL Server in the container and enable the external script.
6. Run R/Python script using sp_execute_external_script.
