#!/usr/bin/env bash

source ../../dev 2> /dev/null;

function login() {
    docker exec -it --user root demo-${secondArg} bash;
    return 0;
}
