#!/bin/sh
if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-sqlservr}:x:$(id -u):0:${USER_NAME:-sqlservr} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi
exec "$@"
