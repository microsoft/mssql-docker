# mssql server 2014 express image listening on static port 1433
#
# Note: This dockerfile is based on Buc Rogers' work here:
# https://github.com/brogersyh/Dockerfiles-for-windows/tree/master/sqlexpress
#
# .NET 3.5 required for SQL Server
FROM microsoft/dotnet-framework:3.5

# maintainer for image metadata
MAINTAINER Perry Skountrianos

# set environment variables
ENV sql_express_download_url "https://download.microsoft.com/download/1/5/6/156992E6-F7C7-4E55-833D-249BD2348138/ENU/x64/SQLEXPR_x64_ENU.exe"
ENV sa_password _
ENV attach_dbs "[]"

# make install files accessible
COPY . /
WORKDIR /

# download and install Microsoft SQL 2014 Express Edition in one step
RUN powershell -Command (New-Object System.Net.WebClient).DownloadFile('%sql_express_download_url%', 'sqlexpress.exe') && /sqlexpress.exe /qs /x:setup && /setup/setup.exe /q /ACTION=Install /INSTANCENAME=SQLEXPRESS /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT="NT AUTHORITY\System" /SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS" /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS && del /F /Q sqlexpress.exe && rd /q /s setup

RUN powershell -Command \
        set-strictmode -version latest ; \
        stop-service MSSQL`$SQLEXPRESS ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql12.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpdynamicports -value '' ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql12.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpport -value 1433 ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql12.SQLEXPRESS\mssqlserver\' -name LoginMode -value 2 ;

CMD powershell ./start -sa_password %sa_password% -attach_dbs \"%attach_dbs%\" -Verbose
