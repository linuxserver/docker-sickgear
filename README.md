[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!

# [linuxserver/sickgear](https://github.com/linuxserver/docker-sickgear)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/sickgear.svg)](https://microbadger.com/images/linuxserver/sickgear "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/sickgear.svg)](https://microbadger.com/images/linuxserver/sickgear "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/sickgear.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/sickgear.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-sickgear/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-sickgear/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/sickgear/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/sickgear/latest/index.html)

[SickGear](https://github.com/sickgear/sickgear) provides management of TV shows and/or Anime, it detects new episodes, links downloader apps, and more.. 

For more information on SickGear visit their website and check it out: https://github.com/SickGear/SickGear


[![sickgear](https://raw.githubusercontent.com/wiki/SickGear/SickGear.Wiki/images/SickGearLogo.png)](https://github.com/sickgear/sickgear)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/sickgear` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=sickgear \
  -e PUID=1000 \
  -e PGID=1000 \
  -p 8081:8081 \
  -v <path to data>:/config \
  -v <path to data>:/tv \
  -v <path to data>:/downloads \
  --restart unless-stopped \
  linuxserver/sickgear
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  sickgear:
    image: linuxserver/sickgear
    container_name: sickgear
    environment:
      - PUID=1000
      - PGID=1000
    volumes:
      - <path to data>:/config
      - <path to data>:/tv
      - <path to data>:/downloads
    ports:
      - 8081:8081
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 8081` | will map the container's port 8081 to port 8081 on the host |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-v /config` | this will store any uploaded data on the docker host |
| `-v /tv` | where you store your tv shows |
| `-v /downloads` | your downloads folder for post processing (must not be donwload in progress) |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

## Setting up the application

Access the webui at `<your-ip>:8081`, for more information check out [SickGear](https://github.com/sickgear/sickgear).

## Migration

Non linuxserver.io containers are known to have the following configuration differences and may need SickGear or docker changes to migrate an existing setup

* The post processing directory which is volume mounted as `downloads` within this container may be `incoming` in other versions.

* The permissions environmental variables which are defined as `PGID` and `PUID` within this container may have been `APP_UID` and `APP_UID` in other versions.

* The configuration file directory which is volume mounted as `config` within this container may be set as the environmetal variable `APP_DATA` in other versions.

* The cache directory which is set in `config.ini` may be configured as a fixed path `cache_dir = /data/cache`. 
Symptoms of this issue include port usage problems and a failure to start the web server log entries. 
Whilst the container is stopped alter this directive to `cache_dir = cache` which will allow SickGear to look for the folder relative to the volume mounted `/config` directory.

It is recommended that a clean install be completed, rather than a migration, however if migration is necessary:

* start a new instance of this image

* compare and align SickGear version numbers bewteen old and new. Ideally they should match but at a minumum the old vesion should be a lower version number to allow SickGear itself to try and migrate

* stop both containers

* notice the configuration difference and migrate copies of the old settings into the new app

* start the new container and test



## Support Info

* Shell access whilst the container is running: `docker exec -it sickgear /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f sickgear`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' sickgear`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/sickgear`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/sickgear`
* Stop the running container: `docker stop sickgear`
* Delete the container: `docker rm sickgear`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start sickgear`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull sickgear`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d sickgear`
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once sickgear
  ```
* You can also remove the old dangling images: `docker image prune`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic: 
```
git clone https://github.com/linuxserver/docker-sickgear.git
cd docker-sickgear
docker build \
  --no-cache \
  --pull \
  -t linuxserver/sickgear:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`
```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **28.06.19:** - Rebasing to alpine 3.10.
* **23.03.19:** - Switching to new Base images, shift to arm32v7 tag.
* **22.02.19:** - Rebasing to alpine 3.9.
* **07.11.18:** - Pipeline prep
* **07.07.18:** - Initial draft release
