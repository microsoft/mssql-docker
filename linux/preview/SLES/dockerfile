# use/sles image, you need to import it from SUSE.
# Info: https://www.suse.com/documentation/sles-12/singlehtml/book_sles_docker/book_sles_docker.html#Customizing_Pre-build_Images
FROM suse/sles12sp2

ADD *.repo /etc/zypp/repos.d/
ADD *.service /etc/zypp/services.d/

RUN zypper refs && zypper refresh

RUN zypper addrepo -fc https://packages.microsoft.com/config/sles/12/mssql-server-preview.repo

RUN zypper --gpg-auto-import-keys refresh

RUN zypper install -y mssql-server

COPY ./mssql.conf /var/opt/mssql/

EXPOSE 1433

CMD /opt/mssql/bin/sqlservr