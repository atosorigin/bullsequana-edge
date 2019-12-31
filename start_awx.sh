#!/bin/sh

. ./proxy.sh
. ./versions.sh

echo "starting MISM containers ...."
docker-compose -f docker_compose_awx.yml up -d
echo "----------------------------------------------------------------"
echo "AWX is available on https://localhost"
echo "pgadmin is available on http://localhost:7070"
echo "for more info, refer to github site "
echo "https://github.com/atosorigin/bullsequana-edge-system-management"
echo "----------------------------------------------------------------"

