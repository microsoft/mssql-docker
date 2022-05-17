FROM opensuse/leap:15.4

RUN zypper install --no-confirm --no-recommends \
    # install setcap to be used later
    # curl is needed for rpm import
    libcap-progs curl && \
    rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    zypper rm --no-confirm --clean-deps curl

# consider merging the two RUNs to save ~ 100mb at the cost of caching adding the signing key

# add mssql-server repo
RUN zypper addrepo --no-check https://packages.microsoft.com/config/sles/15/mssql-server-2019.repo && \
    zypper refresh packages-microsoft-com-mssql-server-2019 && \
    # install mssql-server
    zypper install --no-confirm --auto-agree-with-licenses --no-recommends mssql-server && \
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
