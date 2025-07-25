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

## Usage

Here are some example snippets to help you get started creating a container.

### docker-compose ([recommended](https://docs.linuxserver.io/general/docker-compose))

```yaml
---
services:
  arr-in-one:
    image: ghcr.io/thespad/arr-in-one
    container_name: arr-in-one
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - SONARR= #optional
      - RADARR= #optional
      - LIDARR= #optional
      - READARR= #optional
      - PROWLARR= #optional
      - WHISPARR= #optional
    volumes:
      - /config:/config
    ports:
      - 8989:8989
      - 7878:7878
      - 8686:8686
      - 8787:8787
      - 9696:9696
      - 6969:6969
    restart: unless-stopped
```

### docker cli

```shell
docker run -d \
  --name=arr-in-one \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e SONARR= `#optional` \
  -e RADARR= `#optional` \
  -e LIDARR= `#optional` \
  -e READARR= `#optional` \
  -e PROWLARR= `#optional` \
  -e WHISPARR= `#optional` \
  -p 8989:8989 \
  -p 7878:7878 \
  -p 8686:8686 \
  -p 8787:8787 \
  -p 9696:9696 \
  -p 6969:6969 \
  -v /config:/config \
  --restart unless-stopped \
  ghcr.io/thespad/arr-in-one
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| ---- | --- |
| `-p 8989:8989` | Sonarr UI |
| `-p 7878:7878` | Radarr UI |
| `-p 8686:8686` | Lidarr UI |
| `-p 8787:8787` | Readarr UI |
| `-p 9696:9696` | Prowlarr UI |
| `-p 6969:6969` | Whisparr UI |
| `-e PUID=1000` | UID to run the applications as. |
| `-e PGID=1000` | GID to run the applications as. |
| `-e TZ=Europe/London` | Specify a timezone to use e.g. Europe/London. |
| `-e SONARR=` | Set to `false` to disable the Sonarr service. |
| `-e RADARR=` | Set to `false` to disable the Radarr service. |
| `-e LIDARR=` | Set to `false` to disable the Lidarr service. |
| `-e READARR=` | Set to `false` to disable the Readarr service. |
| `-e PROWLARR=` | Set to `false` to disable the Prowlarr service. |
| `-e WHISPARR=` | Set to `false` to disable the Whisparr service. |
| `-v /config:/config` | Stores config and application files |

## Environment variables from files (Docker secrets)

You can set any environment variable from a file by using a special prepend `FILE__`.

As an example:

```shell
-e FILE__PASSWORD=/run/secrets/mysecretpassword
```

Will set the environment variable `PASSWORD` based on the contents of the `/run/secrets/mysecretpassword` file.

## Umask for running applications

For all of our images we provide the ability to override the default umask settings for services started within the containers using the optional `-e UMASK=022` setting.
Keep in mind umask is not chmod it subtracts from permissions based on it's value it does not add. Please read up [here](https://en.wikipedia.org/wiki/Umask) before asking for support.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```shell
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Support Info

* Shell access whilst the container is running: `docker exec -it arr-in-one /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f arr-in-one`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. We do not recommend or support updating apps inside the container.

Below are the instructions for updating containers:

### Via Docker Compose

* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull arr-in-one`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d arr-in-one`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Run

* Update the image: `docker pull ghcr.io/thespad/arr-in-one`
* Stop the running container: `docker stop arr-in-one`
* Delete the container: `docker rm arr-in-one`
* Recreate a new container with the same docker run parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* You can also remove the old dangling images: `docker image prune`

### Image Update Notifications - Diun (Docker Image Update Notifier)

>[!TIP]
>We recommend [Diun](https://crazymax.dev/diun/) for update notifications. Other tools that automatically update containers unattended are not recommended or supported.

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:

```shell
git clone https://github.com/thespad/docker-arr-in-one.git
cd docker-arr-in-one
docker build \
  --no-cache \
  --pull \
  -t ghcr.io/thespad/arr-in-one:latest .
```

The arm variants can be built on x86_64 hardware and vice versa using `lscr.io/linuxserver/qemu-static`

```bash
docker run --rm --privileged lscr.io/linuxserver/qemu-static --reset
```

## Versions

* **25.07.25:** - Rebase to Alpine 3.22.
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
