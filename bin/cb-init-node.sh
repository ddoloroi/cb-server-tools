#!/bin/sh

mkdir -p /mnt/couchbase
chown couchbase:couchbase /mnt/couchbase
/opt/couchbase/bin/couchbase-cli node-init \
	-c localhost:8091 -u Administrator -p password \
	--node-init-data-path=/mnt/couchbase/data \
	--node-init-index-path=/mnt/couchbase/index

