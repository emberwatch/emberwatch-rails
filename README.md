# README

This repository contains a Docker based development environment. To get it
running, direnv should be installed on your computer and be allowed for the
directory of this project. This will set the `COMPOSE_PROJECT_NAME` when
entering it.

## Setup

The following components need to be installed and configured properly on your
machine:

* [direnv](https://direnv.net/)
* [Docker](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)

After cloning this repository and entering it's directory, direnv need to be
permitted and the docker images need to be build.

```
git clone git@github.com:emberwatch/emberwatch-rails.git
cd emberwatch-rails
direnv allow
docker-compose build
```

Then rails can be used to create and migrate the database and the development
setup can then be span up using Docker Compose.

```
docker-compose run web rails db:create db:schema:load db:migrate
```

## Development

The Docker Compose file mounts the project directory into the running container
so the server and tests are live updated during the development. To start the
server, just use

```
docker-compose up
```

To run the tests continuously during development, just start guard within the
docker container.

```
docker-compose run web guard
```

Also the [rspec-apib](https://github.com/spieker/rspec-apib) Gem is installed on
the project to generate API documentation off of the request specs. This can be
enabled by setting the `APIB` environment variable to `true`.

```
docker-compose run -e RPIB=true web rspec
```
