# mssql server 2016 vNext  image
FROM microsoft/windowsservercore

# maintainer for image metadata
MAINTAINER Perry Skountrianos

# set environment variables
ENV sql_vnext_download_url "https://go.microsoft.com/fwlink/?linkid=829176"

ENV sa_password _
ENV attach_dbs "[]"
ENV ACCEPT_EULA _

# make install files accessible
COPY . /
WORKDIR /

# download and install Microsoft SQL Server vNext in one step
RUN powershell -Command (New-Object System.Net.WebClient).DownloadFile('%sql_vnext_download_url%', 'sqlvnext.exe') && /sqlvnext.exe /qs /x:setup && /setup/setup.exe /q /ACTION=Install /INSTANCENAME=SQL /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT="NT AUTHORITY\System" /SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS" /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS && del /F /Q sqlvnext.exe && rd /q /s setup

RUN powershell -Command \
        set-strictmode -version latest ; \
        stop-service MSSQL`$SQL ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.SQL\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpdynamicports -value '' ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.SQL\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpport -value 1433 ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.SQL\mssqlserver\' -name LoginMode -value 2 ;

CMD powershell ./start -sa_password %sa_password% -ACCEPT_EULA %ACCEPT_EULA% -attach_dbs \"%attach_dbs%\" -Verbose
