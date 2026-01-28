# mssql-nodejs-tedious
# Node.js runtime with tedious to connect to SQL Server
FROM ubuntu:16.04

RUN echo "Installing system utilities" \
    && apt-get update \
    && apt-get install -y curl apt-utils apt-transport-https debconf-utils gcc build-essential g++-5 && \

    echo "Adding custom MS repository" \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list && \

    echo "Installing SQL Server tools" \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y mssql-tools \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
    && /bin/bash -c "source ~/.bashrc" && \

    echo "Installing nodejs libraries" \
    && apt-get update \
    && apt-get install -y nodejs npm --no-install-recommends && \

    echo "Installing necessary locales" \
    && apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen && \

    echo "Installing additional utilities" \
    && apt-get update \
    && apt-get install gettext nano vim -y && \

    echo "Cleaning cache" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# add sample code
RUN mkdir /sample
ADD . /sample

WORKDIR /sample

# start project and install tedious
RUN npm init -y && \
    npm install tedious

CMD /bin/bash ./entrypoint.sh
