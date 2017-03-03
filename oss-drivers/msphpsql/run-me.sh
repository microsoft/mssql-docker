printf "\n### PHP Development Environment for SQL Server ###\n\n"

printf "This container includes everything necessary to start working with PHP against SQL Server. Contents:\n\t- ODBC Drivers\n\t- msphpsql connector module.\n\t- A working PHP to SQL Server sample.\n\t- SQL Server command-line utilities.\n\nTo start an interactive shell session with this container:\n\tdocker run -it microsoft/msphpsql\n\n"

if [ "$DB_HOST" ] && [ "$DB_USERNAME" ] && [ "$DB_PASSWORD" ]
then
    printf "Provided environment variables:\n\t- Host:$DB_HOST\n\t- User:$DB_USERNAME\n\t- Password:$DB_PASSWORD\n\n"
    
    envsubst <sample.php > connect.php

    printf "Environment variables have been written in /sample/connect.php\n\n"

    printf "To run the sample with the provided environment variables, run from within the container:php connect.php\n\n"
fi

printf "To connect to SQL Server using sqlcmd, use:\n\tdocker run microsoft/msphpsql sqlcmd -S <server_name> -U <db_username> -P <db_password>\n\n"

printf "For more samples, visit: http://aka.ms/sqldev\n"

/bin/bash