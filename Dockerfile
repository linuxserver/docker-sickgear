FROM lsiobase/alpine.python:3.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="xe, sparkyballs"

# set python to use utf-8 rather than ascii.
ENV PYTHONIOENCODING="UTF-8"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
        gcc \
        musl-dev \
        python-dev && \
 echo "install pip packages ****" && \
 pip install -U \
        regex \
        scandir && \
 echo "**** install app ****" && \
 TAG_NAME="$(curl -sX GET https://api.github.com/repos/sickgear/sickgear/releases/latest | grep 'tag_name' | cut -d\" -f4)" && \
 git clone -b $TAG_NAME --single-branch --depth 1 https://github.com/SickGear/SickGear /app/sickgear && \
 echo "**** cleanup ****" && \
 apk del --purge \
        build-dependencies

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8081
VOLUME /config /downloads /tv

