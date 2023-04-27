# omop_atlas_webapi



## Getting started

Download a project using commang
```
git clone https://gitlab.com/i3335/omop_atlas_webapi.git
```

There are three files which should be edited

- [ ] /webapi/src/main/resources/db/migration/postgresql/V9.9.9__artificial_dataset.sql
- [ ] /webapi/pom.xml
- [ ] /atlas/docker/config-local.js

In all of them replace IP address 192.168.1.8 to the IP adress of the PC where you launch this container
DO not use localhost or 127.0.0.1 !!!

Build the container and launch it
```
docker-compose build
docker-compose up
```

Building may take long time and it depends on the performance of host computer


Whait for a couple of minutes after the launch for the initialisation of container

Atlas will be available here http://192.168.1.8:8081/atlas/
Where 192.168.1.8 is the IP adress of the computer with container
