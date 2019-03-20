# List of files

- `Dockerfile` - main template file
- `./overlay/tmp/install.sh` - helper file to install mssql-server, mssql-server-extensibility and mssql-mlservices R and python.
- `./overlay/tmp/supervisord.conf` - config file to start mssql-server and launchpad services with supervisor.
- `build.sh` - script to build mssql-server-mlservices docker image.
- `run.sh` - script to start docker container.

# Usage

1. Download all these files and maintain the dir structure.
2. Run the script `./build.sh` to build the image.
3. Run the script `./run.sh` to start the container.
