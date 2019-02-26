# mssql-mlservices
# Maintainers: Microsoft Corporation 

# Base OS layer
FROM ubuntu:16.04

# use root user
USER root

# copy files
#
COPY ./overlay /

# run install
#
RUN /tmp/install.sh

# locale-gen
#
RUN locale-gen en_US.UTF-8

# SQL Server port
#
EXPOSE 1433

# start services with supervisord
# 
CMD /usr/bin/supervisord -n -c /usr/local/etc/supervisord.conf
