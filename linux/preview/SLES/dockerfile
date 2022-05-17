#
# Note: This image requires an active SLES15 subscription to build.
# 
# Thank you to our SUSE Partners for helping with this :)
#
# Assumptions
# 1. use a matching version to the underlying build host
# 2. ensure it is registered to have access to needed repos
#	then leveraging container-suseconnect-zypp
#	e.g. zypper ref
#	Repository 'SLE-Module-Containers12-Pool' is up to date.
#	Repository 'SLE-Module-Containers12-Updates' is up to date.
#	Repository 'SLES12-SP5-Pool' is up to date.
#	Repository 'SLES12-SP5-Updates' is up to date.
#	All repositories have been refreshed.
# 3. minimize the layers by consolidating commands

FROM registry.suse.com/suse/sle15:15.3

ENV ADDITIONAL_MODULES=sle-module-legacy

RUN zypper install --no-confirm --no-recommends \
    # install setcap to be used later
    # curl is needed for rpm import
    libcap-progs curl && \
    rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    zypper rm --no-confirm --clean-deps curl

# consider merging the two RUNs to save ~ 40mb at the cost of caching adding the signing key

# add mssql-server repo
RUN zypper addrepo --no-check https://packages.microsoft.com/config/sles/15/mssql-server-2019.repo && \
    zypper refresh packages-microsoft-com-mssql-server-2019 && \
    # install mssql-server
    zypper install --no-confirm --auto-agree-with-licenses --no-recommends mssql-server && \
    # add mssql-tools repo
    zypper addrepo --check https://packages.microsoft.com/config/sles/15/prod.repo && \
    zypper refresh packages-microsoft-com-prod && \
    # install mssql-tools (consider removing to reduce size) Microsoft already maintains a separate mssql-tools image
    ACCEPT_EULA=Y zypper install --no-confirm --no-recommends mssql-tools && \
    zypper clean --all && \
    # post installation of SQL Server the mssql user/group is created
    # so set the right permissions to the msssql folder
    mkdir -p -m 770 /var/opt/mssql && \
    chown -R mssql /var/opt/mssql && \
    # grant sql the permissions to connect to ports <1024 as a non-root user
    setcap 'cap_net_bind_service+ep' /opt/mssql/bin/sqlservr && \
    # allow dumps from the non-root process
    setcap 'cap_sys_ptrace+ep' /opt/mssql/bin/paldumper && \        
    setcap 'cap_sys_ptrace+ep' /usr/bin/gdb && \
    # ldconfig file because setcap causes the os to remove LD_LIBRARY_PATH
    # and other env variables that control dynamic linking
    mkdir -p /etc/ld.so.conf.d && \
    touch /etc/ld.so.conf.d/mssql.conf && \
    echo -e "# mssql libs\n/opt/mssql/lib" >> /etc/ld.so.conf.d/mssql.conf && \
    ldconfig

EXPOSE 1433

USER mssql

CMD ["/opt/mssql/bin/sqlservr"]
