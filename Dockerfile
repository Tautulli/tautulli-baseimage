FROM python:3.13-slim

LABEL maintainer="Tautulli"

ARG TARGETARCH

COPY requirements.txt requirements.txt

RUN \
  BUILD_DEPS="" && \
  if [ "$TARGETARCH" = "arm" ] && python -c 'import sys; sys.exit(sys.version_info < (3, 14))'; then \
    BUILD_DEPS="gcc libc6-dev libffi-dev"; \
  fi && \
  apt-get update -q -y --no-install-recommends && \
  apt-get install -q -y --no-install-recommends \
    curl \
    gosu \
    $BUILD_DEPS && \
  pip install --no-cache-dir --upgrade pip && \
  pip install --no-cache-dir --upgrade \
    --extra-index-url https://www.piwheels.org/simple \
    -r requirements.txt && \
  if [ -n "$BUILD_DEPS" ]; then apt-get purge -y --auto-remove $BUILD_DEPS; fi && \
  rm requirements.txt && \
  rm -rf /var/lib/apt/lists/*
