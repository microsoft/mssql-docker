# The script sets the sa password and start the SQL Service 
# Also it attaches additional database from the disk
# The format for attach_dbs

param(
[Parameter(Mandatory=$false)]
[string]$sa_password,

[Parameter(Mandatory=$false)]
[string]$ACCEPT_EULA,

[Parameter(Mandatory=$false)]
[string]$attach_dbs,

[Parameter(Mandatory=$false)]
[string]$restore_dbs,

[Parameter(Mandatory=$false)]
[string]$base_db_folder,

[Parameter(Mandatory=$false)]
[ValidateSet("true", "false")]
[string]$use_hostname_folder
)


if($ACCEPT_EULA -ne "Y" -And $ACCEPT_EULA -ne "y")
{
	Write-Verbose "ERROR: You must accept the End User License Agreement before this container can start."
	Write-Verbose "Set the environment variable ACCEPT_EULA to 'Y' if you accept the agreement."

    exit 1 
}
$service = 'MSSQL$SQLEXPRESS'
$passwordSecureString = ConvertTo-SecureString -String $sa_password -AsPlainText -Force;
# start the service
Write-Verbose "Starting SQL Server"
start-service $service

if($sa_password -eq "_") {
    $secretPath = $env:sa_password_path
    if (Test-Path $secretPath) {
        $sa_password = Get-Content -Raw $secretPath
    }
    else {
        Write-Verbose "WARN: Using default SA password, secret file not found at: $secretPath"
    }
}

if($sa_password -ne "_")
{
    Write-Verbose "Changing SA login credentials"
    $sqlcmd = "ALTER LOGIN sa with password=" +"'" + $sa_password + "'" + ";ALTER LOGIN sa ENABLE;"
    & sqlcmd -Q $sqlcmd
}

if (($attach_dbs) -and ($attach_dbs -ne ""))
{
    $attach_dbs_cleaned = $attach_dbs.TrimStart('\\').TrimEnd('\\')

    $dbs = $attach_dbs_cleaned | ConvertFrom-Json

    if ($null -ne $dbs -And $dbs.Length -gt 0)
    {
        Write-Verbose "Attaching $($dbs.Length) database(s)"
            
        Foreach($db in $dbs) 
        {            
            $files = @();
            Foreach($file in $db.dbFiles)
            {
                $files += "(FILENAME = N'$($file)')";           
            }

            $files = $files -join ","
            $sqlcmd = "IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME = '" + $($db.dbName) + "') BEGIN EXEC sp_detach_db [$($db.dbName)] END;CREATE DATABASE [$($db.dbName)] ON $($files) FOR ATTACH;"

            Write-Verbose "Invoke-Sqlcmd -Query $($sqlcmd)"
            & sqlcmd -Q $sqlcmd
        }
    }
}

. (Join-Path $PSScriptRoot scripts\Restore-SqlDatabases.ps1) -sql_server_instance 'localhost' -restore_dbs $restore_dbs -base_db_folder $base_db_folder `
    -use_hostname_folder $use_hostname_folder -sql_login_name 'sa' -sql_login_password $passwordSecureString

Write-Verbose "Started SQL Server."

$lastCheck = (Get-Date).AddSeconds(-2) 
while ($true) 
{ 
    Get-EventLog -LogName Application -Source "MSSQL*" -After $lastCheck | Select-Object TimeGenerated, EntryType, Message	 
    $lastCheck = Get-Date 
    Start-Sleep -Seconds 2 
}
