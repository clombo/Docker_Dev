# Docker Development Environment

This repository comprises of a collection of dev tools that I use in my day to day.

## Prerequisites

According to my understanding Docker doesn't support sharing a network between included files as of yet so we will need to create a shared network between the different compose files.
To do this follow the below steps.

I will be using `devnet` as my network name on all my compose files, but this can be any name of your choosing.

### Create a docker network

Create a docker network using the [Docker CLI](https://docs.docker.com/engine/reference/commandline/cli/):

```bash
docker network create devnet
```

### Use the docker network in compose files

In your individual Compose files, define services and attach them to the external network. 

> **_NOTE:_** This configuration is used on all the services available in this repo and you can use that as your reference point as well.


Here's an example of how you can do this:

`docker-compose.example1.yml`

```yaml
version: '3.8'
services:
  service1:
    image: image1
    networks:
      devnet:
        aliases:
          - service1

networks:
  devnet:
    external: true
```

`docker-compose.example2.yml`

```yaml
version: '3.8'
services:
  service2:
    image: image2
    networks:
      devnet:
        aliases:
          - service2

networks:
  devnet:
    external: true
```

### Include the network in the main compose file

Now we can include the network in a main compose file . When you do this, the services defined in different files will share the same network.

`docker-compose.yml`

```yaml
version: '3.8'

include:
  - Example1Folder/docker-compose.example1.yml
  - Example2Folder/docker-compose.example2.yml

networks:
  devnet:
    external: true
```

## Current Services

These are all the services currently configured. If the services have dependencies they will have include files in their respective docker compose files.

### Graylog

Graylog allows you to enrich, correlate, query, and visualize your log information.

#### Dependencies
- MongoDB

#### References
- [Docker Install](https://go2docs.graylog.org/5-0/downloading_and_installing_graylog/docker_installation.htm)

### MongoDb
### MsSql

```
docker exec -it mssql_local bash --init-file .bashrc
```
### Postgres

The postgres container allows you to spin up a postgres instance with a single or multiple databases.

Specify all your databases (comma seperated) using the `POSTGRES_MULTIPLE_DATABASES` environment variable. The `create-multiple-postgres-databases.sh` will create the databases for you.

### RabbitMq
### Smtp4Dev
