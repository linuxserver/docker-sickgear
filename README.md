[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://sickgear.github.io/
[hub]: https://hub.docker.com/r/linuxserver/sickgear/
[localesurl]: https://sickgear.github.io/


[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]


## Contact information:-

| Type | Address/Details |
| :---: | --- |
| Discord | [Discord](https://discord.gg/YWrKVTn) |
| Forum | [Linuserver.io forum][forumurl] |
| IRC | freenode at `#linuxserver.io` more information at:- [IRC][ircurl]
| Podcast | Covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation! [Linuxserver.io Podcast][podcasturl] |


The [LinuxServer.io][linuxserverurl] team brings you another image release featuring :-

 + regular and timely application updates
 + easy user mappings
 + custom base image with s6 overlay
 + security updates

# linuxserver/sickgear(huburl)
[![](https://raw.githubusercontent.com/wiki/SickGear/SickGear.Wiki/images/SickGearLogo.png)](https://microbadger.com/images/linuxserver/sickgear "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/sickgear.svg)](https://microbadger.com/images/linuxserver/sickgear "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/sickgear.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/sickgear.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-sickgear)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-sickgear/)

SickGear provides management of TV shows and/or Anime, it detects new episodes, links downloader apps, and more.. [sickgear](https://github.com/SickGear/SickGear/)

[![sickgear](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/sickgear-banner.png)][appurl]

 
&nbsp;

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

&nbsp;

## Required Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side.
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.

| Parameter | Function |
| :---: | --- |
| `-p 8081` | the port(s) |
| `-v /config` | Contains your config files and data storage for sickgear|
| `-v /downloads` | Your downloads folder for post processing(must not be donwload in progress)|
| `-v /tv` |  Your tv-shows folder|
| `-v /config` | Contains your config files and data storage for sickgear|
| `-e PGID` | for GroupID, see below for explanation |
| `-e PUID` | for UserID, see below for explanation |

&nbsp;

## Optional Parameters

The application accepts extra environment variables to further customize itself on boot:

  | Parameter | Function |
| :---: | --- |
| `-e TZ` | The timezone the application will use IE US/Pacific|

&nbsp;

## User / Group Identifiers

Sometimes when using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and it will "just work" &trade;.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

&nbsp;

## Setting up the application

Access the webui at `<your-ip>:8081`, for more information check out [sickgear][appurl].

&nbsp;

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

&nbsp;


## Container access and information.

| Function | Command |
| :--- | :--- |
| Shell access (live container) | `docker exec -it sickgear /bin/bash` |
| Realtime container logs | `docker logs -f sickgear` |
| Container version number | `docker inspect -f '{{ index .Config.Labels "build_version" }}' sickgear` |
| Image version number |  `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/sickgear` |

&nbsp;

## Versions

|  Date | Changes |
| :---: | --- |
| 07.07.18 |  Initial Draft Release. |
