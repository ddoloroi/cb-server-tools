#!/bin/sh

# Delete Bucket
/opt/couchbase/bin/couchbase-cli bucket-delete -c localhost:8091 \
-u Administrator -p password \
--bucket=default \
--wait --force

# Create Bucket
/opt/couchbase/bin/couchbase-cli bucket-create -c localhost:8091 \
-u Administrator -p password \
--bucket=default \
--bucket-type=couchbase \
--bucket-ramsize=1024 \
--bucket-replica=1 \
--wait --force

