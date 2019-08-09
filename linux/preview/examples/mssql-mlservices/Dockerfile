# Maintainers: Microsoft Corporation 
FROM ubuntu:16.04

# copy in supervisord conf file
COPY ./supervisord.conf /usr/local/etc/supervisord.conf

# install supporting packages
RUN apt-get update
RUN apt-get install -y supervisor \
                       fakechroot \
                       locales \
                       iptables \
                       sudo \
                       wget \
                       curl \
                       zip \
                       unzip \
                       make \ 
                       bzip2 \ 
                       m4 \
                       apt-transport-https \
                       tzdata \
                       libnuma-dev \
                       libsss-nss-idmap-dev \
                       software-properties-common

# register Microsoft package repository
#TODO: This needs to be updated when SQL Server 2019 is generally available
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
RUN add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-preview.list)"

# install SQL Server ML services R and Python packages which will also install the mssql-server pacakge, the package for SQL Server itself
# if you want to install only Python or only R, you can add/remove the package as needed below
RUN apt-get update
RUN apt-get install -y mssql-mlservices-packages-r  mssql-mlservices-packages-py

# run checkinstallextensibility.sh
RUN /opt/mssql/bin/checkinstallextensibility.sh

# set directory permissions and create default directories
RUN chown -R root:root /opt/mssql/bin/launchpadd
RUN chown -R root:root /opt/mssql/bin/setnetbr
RUN mkdir -p /var/opt/mssql-extensibility/data
RUN mkdir -p /var/opt/mssql-extensibility/log

# cleanup
RUN apt-get clean
RUN rm -rf /var/apt/cache/* /tmp/* /var/tmp/*

# locale-gen
RUN locale-gen en_US.UTF-8

# expose SQL Server port
EXPOSE 1433

# start services with supervisord
CMD /usr/bin/supervisord -n -c /usr/local/etc/supervisord.conf