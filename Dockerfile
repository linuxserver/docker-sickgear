# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.18

# set version label
ARG UNRAR_VERSION=6.2.10
ARG BUILD_DATE
ARG VERSION
ARG SICKGEAR_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="xe, homerr"

# set python to use utf-8 rather than ascii.
ENV PYTHONIOENCODING="UTF-8"

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    build-base && \
  apk add --no-cache \
    python3 && \
  echo "**** install unrar from source ****" && \
  mkdir /tmp/unrar && \
  curl -o \
    /tmp/unrar.tar.gz -L \
    "https://www.rarlab.com/rar/unrarsrc-${UNRAR_VERSION}.tar.gz" && \
  tar xf \
    /tmp/unrar.tar.gz -C \
    /tmp/unrar --strip-components=1 && \
  cd /tmp/unrar && \
  make && \
  install -v -m755 unrar /usr/local/bin && \
  echo "**** install app ****" && \
  mkdir -p \
    /app/sickgear/ && \
  if [ -z ${SICKGEAR_RELEASE+x} ]; then \
    SICKGEAR_RELEASE=$(curl -sX GET "https://api.github.com/repos/sickgear/sickgear/commits/dev" \
    | awk '/sha/{print $4;exit}' FS='[""]'); \
  fi && \
  curl -o \
    /tmp/sickgear.tar.gz -L \
    "https://github.com/sickgear/sickgear/archive/${SICKGEAR_RELEASE}.tar.gz" && \
  tar xf \
    /tmp/sickgear.tar.gz -C \
    /app/sickgear/ --strip-components=1 && \
  cd /app/sickgear && \
  python3 -m venv /lsiopy && \
  pip install -U --no-cache-dir \
    pip \
    wheel && \
  pip install --no-cache-dir --find-links https://wheel-index.linuxserver.io/alpine-3.18/ -r requirements.txt && \
  pip install --no-cache-dir --find-links https://wheel-index.linuxserver.io/alpine-3.18/ -r recommended.txt && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    /root/.cache

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8081

VOLUME /config
