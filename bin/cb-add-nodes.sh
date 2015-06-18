#!/bin/sh

for s in $@; do
	echo "add $s"
	/opt/couchbase/bin/couchbase-cli server-add -c localhost:8091 \
		-u Administrator -p password \
		--server-add=$s:8091 \
		--server-add-username=Administrator \
		--server-add-password=password;
done;

