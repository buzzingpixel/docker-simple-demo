#!/usr/bin/env bash

##
 # Vars
 #

ROTATE=4;
DATE_STAMP=$(date +%Y%m%d%H%M%S);
PROJECT_DIR=/var/www/demo.com;
RELEASES_DIR=${PROJECT_DIR}/releases;
STORAGE_DIR=${PROJECT_DIR}/storage;
THIS_RELEASE_DIR=${RELEASES_DIR}/${DATE_STAMP};

##
 # Git pull latest from master
 #
# CD into the repo
pushd ${PROJECT_DIR}/repo;
# Reset git
git reset --hard;
git clean -df;
# Make sure master branch is checked out
git checkout master;
# Pull the master branch
git pull origin master;


##
 # Copy repo contents to release
 #
cp -R ${PROJECT_DIR}/repo ${THIS_RELEASE_DIR};


##
 # Copy storage
 #
cp /var/www/demo.com/storage/.env ${THIS_RELEASE_DIR}/.env;


##
 # Set file permissions
 #
pushd ${THIS_RELEASE_DIR};
mkdir -p ${THIS_RELEASE_DIR}/cache;
chmod -R 0777 ${THIS_RELEASE_DIR}/system/user/cache;


##
 # Build Docker Images
 #
pushd ${THIS_RELEASE_DIR};
docker-compose -f docker-compose.yml -f docker-compose.prod.yml -p demo build;


##
 # Deactivate Docker
 #
pushd ${THIS_RELEASE_DIR};
docker-compose -f docker-compose.yml -f docker-compose.prod.yml -p demo down || printf "\n";
systemctl restart docker.socket docker.service || printf "\n";
docker-compose -f docker-compose.yml -f docker-compose.prod.yml -p demo kill || printf "\n";
docker-compose -f docker-compose.yml -f docker-compose.prod.yml -p demo down || printf "\n";


##
 # Activate Docker
 #
pushd ${THIS_RELEASE_DIR};
docker-compose -f docker-compose.yml -f docker-compose.prod.yml -p demo up -d --remove-orphans --no-color;
## Assume you have an nginx-master container for your reverse proxy
pushd /var/www/nginx-master;
docker-compose down;
docker-compose up -d;


##
 # Prune Docker
 #
docker system prune -f;


##
 # Add convenience symlink
 #
rm ${PROJECT_DIR}/current;
ln -sf ${THIS_RELEASE_DIR} ${PROJECT_DIR}/current;


##
 # Purge old releases
 #
RELEASE_COUNT=0;

for dir in ${RELEASES_DIR}/*; do
    RELEASE_COUNT=$((RELEASE_COUNT+1));
done;

OLD_RELEASE_CUTTOFF=$((RELEASE_COUNT-${ROTATE}));

if [[ ${OLD_RELEASE_CUTTOFF} -gt 0 ]]; then
    i=0;

    for dir in ${RELEASES_DIR}/*; do
        i=$((i+1));

        if [[ ${i} -gt ${OLD_RELEASE_CUTTOFF} ]]; then
            break;
        fi;

        rm -rf ${dir};
    done;
fi;
