#!/bin/sh

. ./check_prerequisites.sh
# comment the next line if you build from your own Dockerfiles with build_awx.sh
. ./remove_awx_containers.sh
. ./proxy.sh
. ./versions.sh

export docker_image=`docker images |grep 'bullsequana-edge-system-management_awx_web' |awk '{ print $3; }'`
if [ -z "$docker_image" ] 
then
  if [ -f bullsequana-edge-system-management_awx_web.$MISM_BULLSEQUANA_EDGE_VERSION.tar ]
  then
    echo "loading Bull AWX web image ...."
    docker load --input bullsequana-edge-system-management_awx_web.$MISM_BULLSEQUANA_EDGE_VERSION.tar
  fi
fi

export docker_image=`docker images |grep 'bullsequana-edge-system-management_awx_task' |awk '{ print $3; }'`
if [ -z "$docker_image" ] 
then
  if [ -f bullsequana-edge-system-management_awx_task.$MISM_BULLSEQUANA_EDGE_VERSION.tar ]
  then
    echo "loading Bull AWX task image ...."
    docker load --input bullsequana-edge-system-management_awx_task.$MISM_BULLSEQUANA_EDGE_VERSION.tar
  fi
fi

export docker_image=`docker images |grep 'ansible/awx_web' |awk '{ print $3; }'`
if [ -z "$docker_image" ] 
then
  if [ -f awx_web.$MISM_BULLSEQUANA_EDGE_VERSION.tar ]
  then
    echo "loading ansible/awx_web image ...."
    docker load --input awx_web.$MISM_BULLSEQUANA_EDGE_VERSION.tar
  fi
fi

export docker_image=`docker images |grep 'ansible/awx_task' |awk '{ print $3; }'`
if [ -z "$docker_image" ] 
then
  if [ -f awx_task.$MISM_BULLSEQUANA_EDGE_VERSION.tar ]
  then
    echo "loading ansible/awx_task image ...."
    docker load --input awx_task.$MISM_BULLSEQUANA_EDGE_VERSION.tar
  fi
fi

export docker_image=`docker images |grep 'rabbitmq' |awk '{ print $3; }'`
if [ -z "$docker_image" ] 
then
  if [ -f rabbitmq.$MISM_BULLSEQUANA_EDGE_VERSION.tar ]
  then
    echo "loading rabbitmq $MISM_BULLSEQUANA_EDGE_VERSION image ...."
    docker load --input rabbitmq.$MISM_BULLSEQUANA_EDGE_VERSION.tar
  fi
fi

export docker_image=`docker images |grep 'memcached' |awk '{ print $3; }'`
if [ -z "$docker_image" ] 
then
  if [ -f memcached.$MISM_BULLSEQUANA_EDGE_VERSION.tar ]
  then
    echo "loading memcached $MISM_BULLSEQUANA_EDGE_VERSION image ...."
    docker load --input memcached.$MISM_BULLSEQUANA_EDGE_VERSION.tar
  fi
fi

export docker_image=`docker images |grep 'postgres' |awk '{ print $3; }'`
if [ -z "$docker_image" ] 
then
  if [ -f postgres.$MISM_BULLSEQUANA_EDGE_VERSION.tar ]
  then
    echo "loading postgres $MISM_BULLSEQUANA_EDGE_VERSION image ...."
    docker load --input postgres.$MISM_BULLSEQUANA_EDGE_VERSION.tar
  fi
fi

export docker_image=`docker images |grep 'pgadmin4' |awk '{ print $3; }'`
if [ -z "$docker_image" ] 
then
  if [ -f pgadmin4.$MISM_BULLSEQUANA_EDGE_VERSION.tar ]
  then
    echo "loading pgadmin4 $MISM_BULLSEQUANA_EDGE_VERSION image ...."
    docker load --input pgadmin4.$MISM_BULLSEQUANA_EDGE_VERSION.tar
  fi
fi

echo "starting BullSequana Edge Ansible AWX containers ...."
docker-compose -f docker_compose_awx.yml up -d

echo "----------------------------------------------------------------------------------------------------"
echo "now wait 10 minutes for the migration to complete...."
echo "check the login page at https://localhost"
echo "and run ./add_playbooks.sh"
echo "AWX is available on https://localhost"
echo "pgadmin is available on http://localhost:7070"
echo "for more info, refer to github site https://github.com/atosorigin/bullsequana-edge-system-management"
echo "----------------------------------------------------------------------------------------------------"

