# Docker Demo

This repository is meant to demo a simple Docker environment that can be used
for dev, and even deployed if that's your desire. It's meant as a companion to
my live Docker demo.

## Scripting

The `dev` script is the entry point. While you can control everything without
the dev script, the dev script is meant to make things easier. For instance,
depending on the environment, the dev script knows which docker-compose files
to layer into the commands.

### Script options

#### `./dev`

Lists the available commands

#### `./dev build`

Builds the docker images based on the compose files and the Dockerfiles. It
isn't strictly necessary to run this the first time you run `./dev up` as
docker-compose will build the images automatically. Where it comes in handy is
if you make changes to Dockerfiles or the config files built in to the image.
Those won't be picked up until you build, and a build won't be triggered after
the initial build unless you do it manually with this command.

#### `./dev down`

Spins down the environment and containers.

#### `./dev login`

Logs into a bash session in the container. For instance `./dev php` will put you
in a bash shell in the php container. This isn't necessary very often, but once
in a while it can be quite handy.

#### `./dev up`

Spins up the environment and containers.
