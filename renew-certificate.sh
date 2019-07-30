#!/bin/bash
/opt/generate-certificate.sh

echo "Envoy hot restart"
export pid=`pgrep -f hot-restarter.py`
kill -SIGHUP $pid
