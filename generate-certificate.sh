#!/bin/bash

# Generate certificate
number=`(shuf -i 1-1000 -n 1)`
echo "Generating Certificate "$number
openssl req -new -newkey rsa:2048 -nodes -x509 -out /opt/certs/demo.crt -keyout /opt/certs/demo.key -subj '/emailAddress=senkum@sk.com/C=US/ST=CA/L=SJ/O=SK/OU=Dev/CN=SK'$number
