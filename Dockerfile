FROM python:3.11-slim

LABEL maintainer="Tautulli"

COPY requirements.txt requirements.txt

RUN \
  apt-get update -q -y --no-install-recommends && \
  apt-get install -q -y --no-install-recommends \
    curl \
    gosu && \
  pip install --no-cache-dir --upgrade pip && \
  pip install --no-cache-dir --upgrade \
    --extra-index-url https://www.piwheels.org/simple \
    -r requirements.txt && \
  rm requirements.txt && \
  rm -rf /var/lib/apt/lists/*
