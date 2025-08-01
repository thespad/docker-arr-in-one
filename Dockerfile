# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.22

# set version label
ARG BUILD_DATE
ARG VERSION
ARG APP_VERSION
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thespad"
LABEL org.opencontainers.image.source="https://github.com/thespad/docker-arr-in-one"
LABEL org.opencontainers.image.url="https://github.com/thespad/docker-arr-in-one"
LABEL org.opencontainers.image.description="A really dumb proof of concept that bundles the nightly branch builds of all of the *arr applications into a single container"
LABEL org.opencontainers.image.authors="thespad"

# environment settings
ARG APP_BRANCH="nightly"
ARG SONARR_BRANCH="develop"
ENV SONARR_CHANNEL="v4-nightly"
ENV XDG_CONFIG_HOME="/config/xdg"
ENV S6_STAGE2_HOOK="/init-hook"

RUN \
  echo "**** install packages ****" && \
  apk add -U --upgrade --no-cache \
    chromaprint \
    icu-libs \
    sqlite-libs && \
  echo "**** install sonarr ****" && \
  mkdir -p /app/sonarr/bin && \
  if [ -z ${SONARR_VERSION+x} ]; then \
    SONARR_VERSION=$(curl -sX GET http://services.sonarr.tv/v1/releases \
    | jq -r "first(.[] | select(.releaseChannel==\"${SONARR_CHANNEL}\") | .version)"); \
  fi && \
  curl -o \
    /tmp/sonarr.tar.gz -L \
    "https://services.sonarr.tv/v1/update/${SONARR_BRANCH}/download?version=${SONARR_VERSION}&os=linuxmusl&runtime=netcore&arch=x64" && \
  tar xzf \
  /tmp/sonarr.tar.gz -C \
    /app/sonarr/bin --strip-components=1 && \
  echo -e "UpdateMethod=docker\nBranch=${SONARR_BRANCH}\nPackageVersion=${SONARR_VERSION}\nPackageAuthor=[thespad](https://github.com/thespad)" > /app/sonarr/package_info && \
  echo "**** install radarr ****" && \
  mkdir -p /app/radarr/bin && \
  if [ -z ${RADARR_VERSION+x} ]; then \
    RADARR_VERSION=$(curl -sL "https://radarr.servarr.com/v1/update/${APP_BRANCH}/changes?runtime=netcore&os=linuxmusl" \
    | jq -r '.[0].version'); \
  fi && \
  curl -o \
    /tmp/radarr.tar.gz -L \
    "https://radarr.servarr.com/v1/update/${APP_BRANCH}/updatefile?version=${RADARR_VERSION}&os=linuxmusl&runtime=netcore&arch=x64" && \
  tar xzf \
  /tmp/radarr.tar.gz -C \
    /app/radarr/bin --strip-components=1 && \
  echo -e "UpdateMethod=docker\nBranch=${APP_BRANCH}\nPackageVersion=${RADARR_VERSION}\nPackageAuthor=[thespad](https://github.com/thespad)" > /app/radarr/package_info && \
  echo "**** install lidarr ****" && \
  mkdir -p /app/lidarr/bin && \
  if [ -z ${LIDARR_VERSION+x} ]; then \
    LIDARR_VERSION=$(curl -sL "https://lidarr.servarr.com/v1/update/${APP_BRANCH}/changes?runtime=netcore&os=linuxmusl" \
    | jq -r '.[0].version'); \
  fi && \
  curl -o \
    /tmp/lidarr.tar.gz -L \
    "https://lidarr.servarr.com/v1/update/${APP_BRANCH}/updatefile?version=${LIDARR_VERSION}&os=linuxmusl&runtime=netcore&arch=x64" && \
  tar xzf \
  /tmp/lidarr.tar.gz -C \
    /app/lidarr/bin --strip-components=1 && \
  echo -e "UpdateMethod=docker\nBranch=${APP_BRANCH}\nPackageVersion=${LIDARR_VERSION}\nPackageAuthor=[thespad](https://github.com/thespad)" > /app/lidarr/package_info && \
  echo "**** install readarr ****" && \
  mkdir -p /app/readarr/bin && \
  if [ -z ${READARR_VERSION+x} ]; then \
    READARR_VERSION=$(curl -sL "https://readarr.servarr.com/v1/update/${APP_BRANCH}/changes?runtime=netcore&os=linuxmusl" \
    | jq -r '.[0].version'); \
  fi && \
  curl -o \
    /tmp/readarr.tar.gz -L \
    "https://readarr.servarr.com/v1/update/${APP_BRANCH}/updatefile?version=${READARR_VERSION}&os=linuxmusl&runtime=netcore&arch=x64" && \
  tar xzf \
  /tmp/readarr.tar.gz -C \
    /app/readarr/bin --strip-components=1 && \
  echo -e "UpdateMethod=docker\nBranch=${APP_BRANCH}\nPackageVersion=${READARR_VERSION}\nPackageAuthor=[thespad](https://github.com/thespad)" > /app/readarr/package_info && \
  echo "**** install prowlarr ****" && \
  mkdir -p /app/prowlarr/bin && \
  if [ -z ${PROWLARR_VERSION+x} ]; then \
    PROWLARR_VERSION=$(curl -sL "https://prowlarr.servarr.com/v1/update/${APP_BRANCH}/changes?runtime=netcore&os=linuxmusl" \
    | jq -r '.[0].version'); \
  fi && \
  curl -o \
    /tmp/prowlarr.tar.gz -L \
    "https://prowlarr.servarr.com/v1/update/${APP_BRANCH}/updatefile?version=${PROWLARR_VERSION}&os=linuxmusl&runtime=netcore&arch=x64" && \
  tar xzf \
  /tmp/prowlarr.tar.gz -C \
    /app/prowlarr/bin --strip-components=1 && \
  echo -e "UpdateMethod=docker\nBranch=${APP_BRANCH}\nPackageVersion=${PROWLARR_VERSION}\nPackageAuthor=[thespad](https://github.com/thespad)" > /app/prowlarr/package_info && \
  echo "**** install whisparr ****" && \
  mkdir -p /app/whisparr/bin && \
  if [ -z ${WHISPARR_VERSION+x} ]; then \
    WHISPARR_VERSION=$(curl -sL "https://whisparr.servarr.com/v1/update/${APP_BRANCH}/changes?runtime=netcore&os=linuxmusl" \
    | jq -r '.[0].version'); \
  fi && \
  curl -o \
    /tmp/whisparr.tar.gz -L \
    "https://whisparr.servarr.com/v1/update/${APP_BRANCH}/updatefile?version=${WHISPARR_VERSION}&os=linuxmusl&runtime=netcore&arch=x64" && \
  tar xzf \
  /tmp/whisparr.tar.gz -C \
    /app/whisparr/bin --strip-components=1 && \
  echo -e "UpdateMethod=docker\nBranch=${APP_BRANCH}\nPackageVersion=${WHISPARR_VERSION}\nPackageAuthor=[thespad](https://github.com/thespad)" > /app/whisparr/package_info && \
  printf "Version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** cleanup ****" && \
  rm -rf \
    /app/sonarr/bin/Sonarr.Update \
    /app/radarr/bin/Radarr.Update \
    /app/lidarr/bin/Lidarr.Update \
    /app/readarr/bin/Readarr.Update \
    /app/prowlarr/bin/Prowlarr.Update \
    /app/whisparr/bin/Whisparr.Update \
    /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 6969 7878 8686 8787 8989 9696

VOLUME /config
