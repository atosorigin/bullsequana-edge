#set base image 
FROM zabbix/zabbix-agent:centos-4.4.1

USER root 

ENV MISM_BULLSEQUANA_EDGE_VERSION=2.0.9

ENV PYTHONWARNINGS="ignore:Unverified HTTPS request"

# security
# COPY zabbix_server.conf /etc/zabbix

RUN yum -y install epel-release
RUN yum -y install gcc
RUN yum -y install openssl
RUN yum -y install python-pip
RUN yum -y update

#RUN yum -y install gammu
RUN pip install --upgrade pip
RUN pip install requests
RUN pip install pycryptodome

