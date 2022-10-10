FROM ghcr.io/linuxserver/baseimage-alpine:3.16

# set version label
ARG UNRAR_VERSION=6.1.7
ARG BUILD_DATE
ARG VERSION
ARG SICKGEAR_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="xe, homerr"

# set python to use utf-8 rather than ascii.
ENV PYTHONIOENCODING="UTF-8"

RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --upgrade --virtual=build-dependencies \
    make \
    g++ \
    gcc && \
  echo "**** install packages ****" && \
  apk add --no-cache \
    py3-cheetah \
    py3-lxml \
    py3-regex && \
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
    SICKGEAR_RELEASE=$(curl -sX GET "https://api.github.com/repos/sickgear/sickgear/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  curl -o \
    /tmp/sickgear.tar.gz -L \
    "https://github.com/sickgear/sickgear/archive/${SICKGEAR_RELEASE}.tar.gz" && \
  tar xf \
    /tmp/sickgear.tar.gz -C \
    /app/sickgear/ --strip-components=1 && \
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
