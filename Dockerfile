FROM lsiobase/alpine:3.12

# set version label
ARG BUILD_DATE
ARG VERSION
ARG SICKGEAR_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="xe, homerr"

# set python to use utf-8 rather than ascii.
ENV PYTHONIOENCODING="UTF-8"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	curl \
	py3-cheetah \
	py3-lxml \
	py3-regex && \
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
 cd /app/sickgear && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/* \
	/root/.cache

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8081
VOLUME /config
