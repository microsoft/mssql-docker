#!/bin/bash
set -o pipefail
# Wait 60 seconds for SQL Server to start up by ensuring that 
# calling SQLCMD does not return an error code, which will ensure that sqlcmd is accessible
# and that system and user databases return "0" which means all databases are in an "online" state
# https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-databases-transact-sql?view=sql-server-2017 

declare DBSTATUS
declare ERRCODE
TIMEOUT=60
START=$(date +%s)
echo "Configure DB script started at $(date)"

while true; do
  DELTA=$(($(date +%s) - START))
  if [[ $DELTA -gt $TIMEOUT ]]; then
    echo "ERROR: SQL Server took more than ${TIMEOUT} seconds to START up or one or more databases are not in an ONLINE state"
    exit 1
  fi

  DBSTATUS=$(/opt/mssql-tools/bin/sqlcmd -h -1 -t 1 -U sa -P ${MSSQL_SA_PASSWORD} -Q "SET NOCOUNT ON; Select SUM(state) from sys.databases" 2>/dev/null | sed -e 's/^[[:space:]]*//')
  ERRCODE=$?
  if [[ "$DBSTATUS" -eq "0" && "$ERRCODE" -eq "0" ]]; then
    echo "INFO: Database ready."
    break
  else
    echo "INFO: Waiting for database to be ready..."
    sleep 1
  fi
done

# Run the setup script to create the DB and the schema in the DB
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i setup.sql

