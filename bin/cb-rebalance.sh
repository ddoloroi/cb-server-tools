#!/bin/sh

/opt/couchbase/bin/couchbase-cli rebalance -c localhost:8091 \
	-u Administrator -p password

