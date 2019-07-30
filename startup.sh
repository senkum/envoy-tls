#!/bin/bash

# Generate the certificate
/opt/generate-certificate.sh

# Start the service
python3 /opt/service.py &

# Create crontab and start cron
cat /opt/cronjob | crontab -
crond

# Start the envoy proxy
python3 /opt/hot-restarter.py /opt/start-envoy.sh
