<?php
    $serverName = "$DB_HOST";
    $connectionOptions = array(
        "Database" => "",
        "Uid" => "$DB_USERNAME",
        "PWD" => "$DB_PASSWORD"
    );
    //Establishes the connection
    $conn = sqlsrv_connect($serverName, $connectionOptions);
    if($conn){
        echo "Connected!";
    }
    else{
        die(
            print_r(sqlsrv_errors(), true)
        );
    }
        
?>