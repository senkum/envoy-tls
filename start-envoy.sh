#!/bin/bash

exec envoy -c /opt/envoy.yaml --restart-epoch $RESTART_EPOCH  --service-cluster mycluster --parent-shutdown-time-s 120
