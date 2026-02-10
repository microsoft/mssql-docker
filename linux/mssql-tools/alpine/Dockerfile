# Builder
FROM alpine:3.8 AS BUILDER

WORKDIR /tmp

RUN apk update
RUN apk add --no-cache curl \
    build-base \
    unixodbc-dev \
    unixodbc \
    freetds-dev \
    gnupg 

RUN curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.6.1.1-1_amd64.apk \
    && curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.6.1.1-1_amd64.apk \
    && curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.6.1.1-1_amd64.sig \
    && curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.6.1.1-1_amd64.sig

RUN https://packages.microsoft.com/keys/microsoft.asc  | gpg --import - \
    && gpg --verify msodbcsql17_17.6.1.1-1_amd64.sig msodbcsql17_17.6.1.1-1_amd64.apk \
    && gpg --verify mssql-tools_17.6.1.1-1_amd64.sig mssql-tools_17.6.1.1-1_amd64.apk

RUN apk add --allow-untrusted msodbcsql17_17.6.1.1-1_amd64.apk \
    &&apk add --allow-untrusted mssql-tools_17.6.1.1-1_amd64.apk


RUN rm -rf /var/cache/apk/*

# Application
FROM alpine:3.8 AS APP
WORKDIR /app
ENV TZ UTC
RUN apk add --no-cache bash tzdata

ENTRYPOINT [ "bash" ] 