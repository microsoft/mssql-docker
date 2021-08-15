#!/usr/bin/env bash

# This script sets the SA_PASSWORD variable from a SA_PASSWORD_FILE if 
# SA_PASSWORD isn't already set and the file pointed to by SA_PASSWORD_FILE
# does exit.

# This enables the password to be set through mounted secrets, via Docker 
# Secrets or Kubernetes Secrets.

set -Ee

trap "Error on line $LINENO" ERR


if [[ "$SA_PASSWORD" == "" && "$SA_PASSWORD_FILE" != "" && -e $SA_PASSWORD_FILE ]]; then
    password="$(< "${SA_PASSWORD_FILE}")"
    export SA_PASSWORD="$password"
fi

/opt/mssql/bin/sqlservr
