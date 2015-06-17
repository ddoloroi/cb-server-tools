#!/bin/sh

PER_SERVER_RAM_QUOTA=`cat /proc/meminfo |grep MemTotal |awk '{print int($2/1024*0.6)}'`
/opt/couchbase/bin/couchbase-cli cluster-init -c localhost:8091 \
	-u Administrator -p password \
	--cluster-init-username=Administrator \
	--cluster-init-password=password \
	--cluster-init-ramsize=$PER_SERVER_RAM_QUOTA

