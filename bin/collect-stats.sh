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

DIR=`dirname $0`
CMD=`$DIR/get-cbstats-command.sh`
while [ true ]
do
  NOW=`date +"%Y-%m-%d %H:%M:%S"`
  STATS=`"$CMD" -b $BUCKET $HOST:11210 all |awk '{printf "%s,", $2}' |awk '{print}'`
  echo $NOW,$STATS
  sleep 5
done


