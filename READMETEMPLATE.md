[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://github.com/SickGear/SickGear
[hub]: https://hub.docker.com/r/linuxserver/sickgear/


[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png?v=4&s=4000)][linuxserverurl]


## Contact information:- 

| Type | Address/Details | 
| :---: | --- |
| Forum | [Linuserver.io forum][forumurl] |
| IRC | freenode at `#linuxserver.io` more information at:- [IRC][ircurl]
| Podcast | Covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation! [Linuxserver.io Podcast][podcasturl] |


The [LinuxServer.io][linuxserverurl] team brings you another image release featuring easy user mapping and based on alpine linux with s6 overlay.

# linuxserver/sickgear
[![](https://images.microbadger.com/badges/version/linuxserver/sickgear.svg)](https://microbadger.com/images/linuxserver/sickgear "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/sickgear.svg)](https://microbadger.com/images/linuxserver/sickgear "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/sickgear.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/sickgear.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-sickgear)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-sickgear/)

SickGear provides management of TV shows and/or Anime, it can detect new episodes, link to downloader apps, and more.  SickGear is a proud descendant of Sick Beard and is humbled to have been endorsed by one of its former lead developers.  

Why SickGear?  
* SickGear maintains perfect uptime with the longest track record of being stable, reliable and trusted to work
* SickGear delivers quality from active development with a wealth of options on a dark or light themed interface
* [Migrating](https://github.com/SickGear/SickGear/wiki/Install-SickGear-%5B0%5D-Migrate) to a hassle free and feature rich set up is super simple

[![sickgear](https://raw.githubusercontent.com/wiki/SickGear/SickGear.Wiki/images/SickGearLogo.png)][appurl]

&n&nbsp;

## Usage

```
docker create \
  --name=sickgear \
  -v <path to config>:/config \
  -v <path to downloads>:/downloads \
  -v <path to tv-shows>:/tv \
  -e PGID=<gid> -e PUID=<uid>  \
  -e TZ=<timezone>
  -p 8081:8081 \
  linuxserver/sickgear
```

&nbsp;

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`



| Parameter | Function |
| :---: | --- |
| `-p 8081` | the port(s) |
| `-v /config` | where sickgear should store its config files |
| `-v /downloads` | your downloads folder |
| `-v /tv` | your tv-shows folder |
| `-e PGID` | for GroupID, see below for explanation |
| `-e PUID` | for UserID, see below for explanation |

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

Web interface is at `<your ip>:8081` , set paths for downloads, tv-shows to match docker mappings via the webui.

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
| dd.MM.yy |  Initial Release. |
