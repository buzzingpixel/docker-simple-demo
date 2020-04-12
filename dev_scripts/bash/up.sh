#!/usr/bin/env bash

source ../../dev 2> /dev/null;

function up() {
    docker network create proxy >/dev/null 2>&1
    docker-compose ${composeFiles} -p demo up -d;
    docker exec -it demo-php bash -c "chmod -R 0777 /opt/project/cache;";
    return 0;
}
