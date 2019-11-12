#!/bin/sh

export MISM_BULLSEQUANA_EDGE_VERSION=2.0.1

export AWX_BULLSEQUANA_EDGE_VERSION=9.0.1
export RABBITMQ_AWX_BULLSEQUANA_EDGE_VERSION=3.8.1-management
export POSTGRES_AWX_BULLSEQUANA_EDGE_VERSION=12.0-alpine
export PGADMIN_AWX_BULLSEQUANA_EDGE_VERSION=4.14
export MEMCACHED_AWX_BULLSEQUANA_EDGE_VERSION=1.5.20-alpine

export ZABBIX_BULLSEQUANA_EDGE_VERSION=centos-4.4.1
export POSTGRES_ZABBIX_BULLSEQUANA_EDGE_VERSION=12.0-alpine

./install_awx.sh
./install_zabbix.sh


