#!/usr/bin/env bash

source ../../dev 2> /dev/null;

function down() {
    docker-compose ${composeFiles} -p demo down;
    return 0;
}
