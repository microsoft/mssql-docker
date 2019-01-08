FROM opensuse:42.3

RUN zypper addrepo -fc https://packages.microsoft.com/config/sles/12/mssql-server-preview.repo

RUN zypper --gpg-auto-import-keys refresh 

RUN zypper install -y mssql-server

RUN cp /var/opt/mssql/mssql.conf /

EXPOSE 1433

ADD ./mssql.conf /var/opt/mssql/

CMD /opt/mssql/bin/sqlservr