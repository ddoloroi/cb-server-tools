#!/bin/sh

HOST=$1
BUCKET=$2

if [ -z $HOST ]; then
  echo "hostname is required."
  exit 1
fi

if [ -z $BUCKET ]; then
  BUCKET=default
fi

while [ true ]
do
  NOW=`date +"%Y-%m-%d %H:%M:%S"`
  STATS=`/opt/couchbase/bin/cbstats -b $BUCKET $HOST:11210 checkpoint |grep num_checkpoint_items |awk '{s += $2} END {print s}'`
  echo $NOW,$STATS
  sleep 5
done


