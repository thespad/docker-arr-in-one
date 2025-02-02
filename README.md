# [thespad/arr-in-one](https://github.com/thespad/docker-arr-in-one)

[![GitHub Release](https://img.shields.io/github/release/thespad/docker-arr-in-one.svg?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github&include_prereleases)](https://github.com/thespad/docker-arr-in-one/releases)
[![Commits](https://img.shields.io/github/commits-since/thespad/docker-arr-in-one/latest?color=26689A&include_prereleases&logo=github&style=for-the-badge)](https://github.com/TheSpad/docker-arr-in-one/commits/main)
![Image Size](https://img.shields.io/docker/image-size/thespad/arr-in-one/latest?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=Size)
[![Docker Pulls](https://img.shields.io/docker/pulls/thespad/arr-in-one.svg?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/thespad/arr-in-one)
[![GitHub Stars](https://img.shields.io/github/stars/thespad/docker-arr-in-one.svg?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/thespad/docker-arr-in-one)
[![Docker Stars](https://img.shields.io/docker/stars/thespad/arr-in-one.svg?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=stars&logo=docker)](https://hub.docker.com/r/thespad/arr-in-one)

[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/thespad/docker-arr-in-one/call-check-and-release.yml?labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github&label=Check%20For%20Upstream%20Updates)](https://github.com/thespad/docker-arr-in-one/actions/workflows/call-check-and-release.yml)
[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/thespad/docker-arr-in-one/call-build-image.yml?style=for-the-badge&logo=github&labelColor=555555&logocolor=ffffff&label=Build%20Image)](https://github.com/thespad/docker-arr-in-one/actions/workflows/call-build-image.yml)

arr-in-one is a really dumb proof of concept that bundles the nightly branch builds (develop for Sonarr as it lacks a nightly branch) of all of the *arr applications into a single container, built daily. This image contains:

* Sonarr
* Radarr
* Lidarr
* Readarr
* Prowlarr
* Whisparr

Each service uses its own subfolder under /config to store its data.

## Supported Architectures

Our images support multiple architectures and simply pulling `ghcr.io/thespad/arr-in-one:latest` should retrieve the correct image for your arch.

The architectures supported by this image are:

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| amd64 | ✅ | latest |
| arm64 | ✅ | latest |

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| ---- | --- |
| `-p 8989` | Sonarr UI |
| `-p 7878` | Radarr UI |
| `-p 8686` | Lidarr UI |
| `-p 8787` | Readarr UI |
| `-p 9696` | Prowlarr UI |
| `-p 6969` | Whisparr UI |
| `-e PUID=1000` | UID to run the applications as. |
| `-e PGID=1000` | GID to run the applications as. |
| `-e TZ=Europe/London` | Specify a timezone to use e.g. Europe/London. |
| `-e SONARR=` | Set to `false` to disable the Sonarr service. |
| `-e RADARR=` | Set to `false` to disable the Radarr service. |
| `-e LIDARR=` | Set to `false` to disable the Lidarr service. |
| `-e READARR=` | Set to `false` to disable the Readarr service. |
| `-e PROWLARR=` | Set to `false` to disable the Prowlarr service. |
| `-e WHISPARR=` | Set to `false` to disable the Whisparr service. |
| `-v /config` | Stores config and application files |

## Versions

* **02.02.25:** - Rebase to Alpine 3.21.
* **02.09.24:** - Unpin Prowlarr version.
* **30.08.24:** - Pin Prowlarr version until update endpoint is fixed.
* **26.05.24:** - Rebase to Alpine 3.20.
* **30.12.23:** - Rebase to Alpine 3.19.
* **14.05.23:** - Rebase to Alpine 3.18.
* **09.12.22:** - Rebase to Alpine 3.17.
* **24.09.22:** - Rebase to Alpine 3.16, migrate to s6v3.
* **18.09.22:** - Update Sonarr to track develop branch.
* **12.04.22:** - Initial Release.
