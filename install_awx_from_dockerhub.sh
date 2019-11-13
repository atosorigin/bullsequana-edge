#!/bin/sh

export NO_PROXY=$NO_PROXY
export HTTP_PROXY=$HTTP_PROXY
export HTTPS_PROXY=$HTTPS_PROXY

export MISM_BULLSEQUANA_EDGE_VERSION=latest
export AWX_BULLSEQUANA_EDGE_VERSION=latest
export RABBITMQ_AWX_BULLSEQUANA_EDGE_VERSION=latest
export POSTGRES_AWX_BULLSEQUANA_EDGE_VERSION=latest
export PGADMIN_AWX_BULLSEQUANA_EDGE_VERSION=latest
export MEMCACHED_AWX_BULLSEQUANA_EDGE_VERSION=latest

echo "starting BullSequana Edge Ansible AWX containers ...."
docker-compose -f docker-compose-awx-from-dockerhub.yml up -d

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "now wait 10 minutes for the migration to complete...."
echo "check the login page at https://localhost"
echo "and run ./add_playbooks.sh"
echo "AWX is available on https://localhost"
echo "pgadmin is available on http://localhost:7070"
echo "for more info, refer to github site https://github.com/atosorigin/bullsequana-edge-system-management ansible part"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"



