param(
    [Parameter(Mandatory=$true)]
    [string]$sql_server_instance,
    
    [Parameter(Mandatory=$false)]
    [string]$restore_dbs,

    [Parameter(Mandatory=$false)]
    [string]$base_db_folder,

    [Parameter(Mandatory=$false)]
	[ValidateSet("true", "false")]
    [string]$use_hostname_folder,

    [Parameter(Mandatory=$false)]
    [string]$sql_login_name,

    [Parameter(Mandatory=$false)]
    [SecureString]$sql_login_password
)

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo.SqlEnum") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo.SmoEnum") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoExtended") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.ConnectionInfo") | Out-Null

# create folders in share with hostname which is the container id by default (if --hostname is not specified explicitly)
if ($use_hostname_folder -eq $true) {
	$base_db_folder = (Join-Path $base_db_folder $env:computername)
}

$data_db_folder = ($base_db_folder + "\Data")
# Right now LOG directory = DATA directory.
$log_db_folder = $data_db_folder

$null = New-Item -ItemType Directory -Force -Path $base_db_folder
$null = New-Item -ItemType Directory -Force -Path $log_db_folder
$null = New-Item -ItemType Directory -Force -Path $data_db_folder

if (($restore_dbs -ne $null) -and ($restore_dbs -ne "")) {

	$restore_dbs_cleaned = $restore_dbs.TrimStart('\\').TrimEnd('\\')
	$rdbs = $restore_dbs_cleaned | ConvertFrom-Json

	if ($null -ne $rdbs -And $rdbs.Length -gt 0) {
		
        Write-Verbose "Restoring $($rdbs.Length) database(s)"

        $server = $null
		# Connect to the specified instance
		# SQL authentication
        if (($sql_login_name -ne $null) -and ($sql_login_name -ne "")) {
            
            Write-Verbose "Connection made via SQL credentials"

            $serverConnection = New-Object Microsoft.SqlServer.Management.Common.ServerConnection $sql_server_instance, $sql_login_name, $sql_login_password
            $server = New-Object Microsoft.SqlServer.Management.Smo.Server $serverConnection

        } else {
            
            Write-Verbose "Connection made via Winauth"

            $server = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $sql_server_instance

        }

		Write-Verbose "Connection to SQL server established"

		# attach exiting databases
		& (Join-Path $PSScriptRoot Attach-AllDatabasesInDir.ps1) -server $server -DatabaseDir $data_db_folder

		# restore databases
		Foreach($rdb in $rdbs)
		{	

			$dbname = $rdb.dbName
			$dbBckFilename = $rdb.bckFile
			Write-Verbose "Database restore"
			Write-Verbose " - DB name: $dbname"
			Write-Verbose " - DB backup file: $dbBckFilename"

			$serverDb = $server.Databases[$dbname];

			if ($serverDb -eq $null) 
			{
				$backupDeviceItem = New-Object Microsoft.SqlServer.Management.Smo.BackupDeviceItem $rdb.bckFile, 'File';
				$restore = New-Object 'Microsoft.SqlServer.Management.Smo.Restore';
				$restore.Database = $rdb.dbName;
				$restore.Devices.Add($backupDeviceItem);

				foreach ($file in $restore.ReadFileList($server)) 
				{
					$relocateFile = New-Object 'Microsoft.SqlServer.Management.Smo.RelocateFile';
					$relocateFile.LogicalFileName = $file.LogicalName;

					if ($file.Type -eq 'D'){
						if($dataFileNumber -ge 1)
						{
							$suffix = "_$dataFileNumber";
						}
						else
						{
							$suffix = $null;
						}

						$relocateFile.PhysicalFileName = "$data_db_folder\$dbname$suffix.mdf";

						$dataFileNumber ++;
					}
					else 
					{
						if($logFileNumber -ge 1)
						{
							$logSuffix = "_$logFileNumber";
						}
						else
						{
							$logSuffix = $null;
						}

						$relocateFile.PhysicalFileName = "$log_db_folder\$dbname$logSuffix.ldf";
					}

					$restore.RelocateFiles.Add($relocateFile) | out-null;
				}

				try
				{
					$restore.SqlRestore($server);

					# Now detach and reattach the database to update logical filesnames. 
					# It is important to be correctly reatached with any container restart.
					Write-Verbose "Database $dbname restored successfully."
					$result = $server.DetachDatabase($dbname, $false, $false)
					& (Join-Path $PSScriptRoot Attach-AllDatabasesInDir.ps1) -server $server -DatabaseDir $data_db_folder -DbNameToAttach $dbname
				}
				catch
				{
					Write-Host "SQL restore DB error: " $_.Exception.Message -ForegroundColor Red
				}
			}
			else
			{
				Write-Verbose "Database $dbname already exists. Skipping the restoration."
			}
		}
	}
}