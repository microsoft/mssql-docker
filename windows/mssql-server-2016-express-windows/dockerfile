# mssql server 2016 express image
#
FROM microsoft/windowsservercore

# maintainer for image metadata
MAINTAINER Perry Skountrianos

# set environment variables
ENV sql_express_download_url "https://go.microsoft.com/fwlink/?linkid=829176"

ENV sa_password _
ENV attach_dbs "[]"

# make install files accessible
COPY . /
WORKDIR /

# download and install Microsoft SQL 2016 Express Edition in one step
RUN powershell -Command (New-Object System.Net.WebClient).DownloadFile('%sql_express_download_url%', 'sqlexpress.exe') && /sqlexpress.exe /qs /x:setup && /setup/setup.exe /q /ACTION=Install /INSTANCENAME=SQLEXPRESS /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT="NT AUTHORITY\System" /SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS" /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS && del /F /Q sqlexpress.exe && rd /q /s setup

RUN powershell -Command \
        set-strictmode -version latest ; \
        stop-service MSSQL`$SQLEXPRESS ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql13.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpdynamicports -value '' ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql13.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpport -value 1433 ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql13.SQLEXPRESS\mssqlserver\' -name LoginMode -value 2 ;

CMD powershell ./start -sa_password %sa_password% -attach_dbs \"%attach_dbs%\" -Verbose
