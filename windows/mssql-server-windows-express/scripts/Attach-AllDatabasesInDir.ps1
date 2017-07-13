<#
    https://blog.netnerds.net/smo-recipes/detach-attach/
#>

param(
    [Parameter(Mandatory=$true)] 
    [object]$server,

    [Parameter(Mandatory=$true)]
    [string]$DatabaseDir = $(throw "-DatabaseDir `"C:\ExampleDir`" is required."),

    [Parameter(Mandatory=$false)]
    [string]$DbNameToAttach
)

$items = get-childitem $DatabaseDir *.mdf 
 
foreach ($item in $items)
{
    [bool]$ErrorExists = $false 
    $itemName = $Item.name
    $itemFullName = $item.fullname
    Write-Verbose "Trying to attach: $itemName ($itemFullName)"

    try    
    { 
        $DBName = $null
        $DBName = ($server.DetachedDatabaseInfo($($item.fullname)) | Where-Object { $_.Property -eq "Database name" }).Value
    }  
    catch 
    { 
        Write-host -foregroundcolor red "File was not able to be read. It is most likely already mounted or in use by another application" 
        $ErrorExists = $true 
    } 

    if (($DbNameToAttach -eq $null) -or ($DbNameToAttach -eq '') -or ($DbNameToAttach -eq $DBName))
    {
        if ($ErrorExists -eq $false) 
        { 
            foreach ($db in $server.databases)
            { 
                if ($db.name.Equals($DBName))
                { 
                    write-host -foreground red "This database already exists on the server" 
                    $ErrorExists = $true 
                } 
            }

            if ($ErrorExists -eq $false)
            { 
                try
                {
                    $DbLocation = new-object System.Collections.Specialized.StringCollection 
                    
                    foreach ($file in $server.EnumDetachedDatabaseFiles($itemFullName)) {
                        Write-Verbose "MDF: $file"
                        $newfilename = Split-Path $($file) -leaf    
                        $newpath = Join-Path $DatabaseDir $newfilename
                        Write-Verbose "MDF (updated): $newpath"
                        $null = $DbLocation.Add($newpath)
                    }
                    
                    foreach ($file in $server.EnumDetachedLogFiles($itemFullName)) {
                        Write-Verbose "LDF: $file"
                        $newfilename = Split-Path $($file) -leaf    
                        $newpath = Join-Path $DatabaseDir $newfilename
                        Write-Verbose "LDF (updated): $newpath"
                        $null = $DbLocation.Add($newpath)
                    }
        
                    Write-Verbose "DB-NAME: $DBName"
                    Write-Verbose "DB-LOCATION: $DbLocation"
                    $attach = $server.AttachDatabase($DBName, $DbLocation) 
                }
                catch
                {
                    Write-Host  -ForegroundColor Red "Attach error: " $_.Exception.Message

                    $e = $_.Exception
                    $msg = $e.Message
                    while ($e.InnerException) 
                    {
                        $e = $e.InnerException
                        $msg += "`n" + $e.Message
                    }
                    Write-Host -ForegroundColor Red " - detail: " $msg
                }
            }
        } 
    } 
}