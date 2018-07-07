[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://sickgear.github.io/
[hub]: https://hub.docker.com/r/linuxserver/sickgear/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/sickgear
[![](https://raw.githubusercontent.com/wiki/SickGear/SickGear.Wiki/images/SickGearLogo.png)](https://microbadger.com/images/linuxserver/sickgear "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/sickgear.svg)](https://microbadger.com/images/linuxserver/sickgear "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/sickgear.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/sickgear.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-sickgear)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-sickgear/)

SickGear provides management of TV shows and/or Anime, it detects new episodes, links downloader apps, and more.. [sickgear](https://github.com/SickGear/SickGear/)

[![sickgear](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/sickgear-banner.png)][appurl]


## Usage

```
docker create --name=sickgear \
-v <path to config>:/config \
-v <path to downloads>:/downloads \
-v <path to tv-shows>:/tv \
-e PGID=<gid> -e PUID=<uid>  \
-e TZ=<timezone> \
-p 8081:8081 \
linuxserver/sickgear
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 8081` - the port(s)
* `-v /config` - where sickgear should store config files.
* `-v /downloads` - your downloads folder
* `-v /tv` - your tv-shows folder
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for timezone information, eg Europe/London

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it sickgear /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

Web interface is at `<your ip>:8081` , set paths for downloads, tv-shows to match docker mappings via the webui.

## Migration

Non linuxserver.io containers are known to have the following configuration differences and may need Sickgear or docker changes to migrate an existing setup

* The post processing directory which is volume mounted as `downloads` within this container may be `incoming` in other versions.

* The permissions environmental variables which are defined as `PGID` and `PUID` within this container may have been `APP_UID` and `APP_UID` in other versions.

* The configuraiton file directory which is volume mounted as `config` within this container may be set as the environmetal variable `APP_DATA` in other versions.

Its is recommened that a clean install be completed rather than a migration however if migration isn ecessary:

* start a new instance of this image

* compare and align Sickgear version numbers bewteen old and new. Ideally they should match but at a minumum the old vesion should be a lower version number to allow Sickgear itself to try an migrate

* stop both containers

* notice the configuraiton difference and migrate copies of the old settings into the new app

* start the new container and test

## Info

* To monitor the logs of the container in realtime `docker logs -f sickgear`.

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' sickgear`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/sickgear`


## Versions

+ **07.07.18:** Initial draft creation
