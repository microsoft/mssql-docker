#!/bin/bash
echo "$0: Starting SQL Server"
docker-entrypoint-initdb.sh & /opt/mssql/bin/sqlservr.sh