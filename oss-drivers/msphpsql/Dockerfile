# mssql-php-msphpsql
# PHP runtime with sqlservr and pdo_sqlsrv to connect to SQL Server
FROM ubuntu:16.04

MAINTAINER SQL Server Connectivity Team

RUN echo "Installing system utilities" \
    && apt-get update \
    && apt-get install -y curl apt-utils apt-transport-https debconf-utils gcc build-essential g++-5 && \

    echo "Adding custom MS repository \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list && \

    echo "Installing SQL Server drivers" \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y unixodbc-dev msodbcsql && \

    echo "Installing SQL Server tools" \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y mssql-tools \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
    && /bin/bash -c "source ~/.bashrc" && \

    echo "Installing php libraries" \
    && apt-get update \
    && apt-get install -y php7.0 libapache2-mod-php7.0 mcrypt php7.0-mcrypt php-mbstring php-pear php7.0-dev --no-install-recommends && \

    echo "Installing necessary locales" \
    && apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen && \

    echo "Installing SQL Server PHP connector module" \
    && pecl install sqlsrv pdo_sqlsrv && \

    echo "Initial configuration of SQL Server PHP connector" \
    && echo "extension=/usr/lib/php/20151012/sqlsrv.so" >> /etc/php/7.0/cli/php.ini \
    && echo "extension=/usr/lib/php/20151012/pdo_sqlsrv.so" >> /etc/php/7.0/cli/php.ini && \

    echo "Installing additional utilities" \
    && apt-get update \
    && apt-get install gettext nano vim -y && \

    echo "Cleaning cache" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* && \

# Adding sample code
RUN mkdir /sample
ADD . /sample

WORKDIR /sample

CMD /bin/bash ./entrypoint.sh
