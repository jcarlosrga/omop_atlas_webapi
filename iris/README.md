### Changelog
2022-04-14
Second container with PostgreSQL was added
PostgreSQL is available on port 5342
User name and password: postgres 1234


### Installation 

1. Clone/git pull the repo into any local directory

```
$ git clone https://gitlab.com/i3335/omop_docker.git
```

2. Open the terminal in this directory and run:

```
$ docker-compose build
```

This step may take some time to complete. Up to 15 minutes may be necessary, depending on your machine power.

3. Run the IRIS container with your project:

```
$ docker-compose up -d
```

### How to Test it

IRIS will be available here
http://IP:52773/csp/healthshare/irisapp/EnsPortal.ProductionConfig.zen?$NAMESPACE=IRISAPP&$NAMESPACE=IRISAPP