#!/bin/bash
# This sample script sets environment variables and starts the docker container.

#####################################
# Set all variables for 'docker run '
#####################################

# set MSSQL_PID to specify SQL Server edition to use
# Details about editions can be found at https://go.microsoft.com/fwlink/?LinkId=852748&clcid=0x409
# E.g., To use the Developer edition: MSSQL_PID='Developer'
#

# set ACCEPT_EULA to specify if you accept the EULA
# set ACCEPT_EULA_ML to specify if you accept the Machine Learning EULA
# The license terms for this product can be found in
# /usr/share/doc/mssql-server or downloaded from: https://go.microsoft.com/fwlink/?LinkId=855862&clcid=0x409
# The privacy statement can be viewed at: https://go.microsoft.com/fwlink/?LinkId=853010&clcid=0x409
# E.g., to accept the EULA: ACCEPT_EULA='Y'
# E.g., to accept the EULA ML: ACCEPT_EULA_ML='Y'
#

# Path to mssql host dir which will be mapped to /var/opt/mssql
# E.g., PATH_TO_MSSQL="${HOME}/mssql"
#

#####################################
# Verify variables are all set
#####################################

if [ -z "$MSSQL_PID" ]; then
    echo "Error: Please edit this script to set MSSQL_PID to specify SQL Server edition to use."
    exit 1
fi

if [ -z "$ACCEPT_EULA" ]; then
    echo "Error: Please edit this script to set ACCEPT_EULA to specify whether or not you accept the EULA."
    exit 1
fi

if [ -z "$ACCEPT_EULA_ML" ]; then
    echo "Error: Please edit this script to set ACCEPT_EULA_ML to specify whether or not you accept the Machine Learning Services EULA."
    exit 1
fi

if [ ! -d "${PATH_TO_MSSQL}" ]; then
    echo "Error: ${PATH_TO_MSSQL} does not exist. Please create the directory or edit this script to set PATH_TO_MSSQL to an existing directory."
    exit 1
fi

#####################################
# Read SA password from input
#####################################
# SA_PASSWORD to set the SQL Server system administrator password.
#
echo -n "Create a password for the SQL Server system administrator (SA account): "
read -s SA_PASSWORD

#####################################
# Start 'docker run'
#####################################
# Docker image.
#
MSSQL_ML_DOCKER_IMG='mssql-server-mlservices:latest'

# Start
DOCKER_RUN="docker run -d -e MSSQL_PID=${MSSQL_PID} -e ACCEPT_EULA=${ACCEPT_EULA} -e ACCEPT_EULA_ML=${ACCEPT_EULA_ML} -e SA_PASSWORD=${SA_PASSWORD} -v ${PATH_TO_MSSQL}:/var/opt/mssql -p 1433:1433 ${MSSQL_ML_DOCKER_IMG}"
eval $DOCKER_RUN
