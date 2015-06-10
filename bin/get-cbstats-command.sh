#!/bin/sh

LINUX="/opt/couchbase/bin/cbstats"
MAC="/Applications/Couchbase Server.app/Contents/Resources/couchbase-core/bin/cbstats"

# echo $MAC

if [ -f $LINUX ]; then
	echo $LINUX
elif [ -f "${MAC}" ]; then
  echo "${MAC}"
fi

