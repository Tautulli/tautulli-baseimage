FROM python:3.9-slim

LABEL maintainer="Tautulli"

RUN \
  apt-get -q -y update --no-install-recommends && \
  apt-get install -q -y --no-install-recommends \
    build-essential libssl-dev libffi-dev \
    curl \
    gosu && \
  pip install --no-cache-dir --upgrade pip && \
  pip install --no-cache-dir --upgrade \ 
    --extra-index-url https://www.piwheels.org/simple \
    cryptography \
    pycryptodomex \
    pyopenssl && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get purge -y --auto-remove \
    build-essential libssl-dev libffi-dev
