#!/bin/sh
CB_VER=`/opt/couchbase/bin/cbstats localhost:11210 all |grep -w version |awk '{print $2}'`
OUT_FILE="${CB_VER}_`showip`_`date +"%Y-%m-%d-%H%M"`_checkpoint_items.log"
while [ true ]
do
  NOW=`date +"%Y-%m-%d %H:%M:%S"`
  STATS=`/opt/couchbase/bin/cbstats localhost:11210 checkpoint |grep num_checkpoint_items |awk '{s += $2} END {print s}'`
  # echo $NOW,$STATS |tee -a $OUT_FILE
  echo $NOW,$STATS >> $OUT_FILE
  sleep 5
done


