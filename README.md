# envoy-tls

A sample of service using envoy proxy with tls. The certificates are automatically generated every 15 minutes(the value can be changed in the cronjob file) and the envoy will restarted be using hot-restarter.py, once envoy is restarted it will use the newly generated certificates

## Usage
    docker build . -t envoy-tls
    docker run -p 443:443 -p 9090:9090 envoy-tls
    curl -k https://localhost/service

Detailed certificate information can be found

    curl -k https://localhost/service --verbose

After 15 mins, Execute the curl with verbose, you will see a new certificate will be used.

## Details

- service.py is the python server which serves a hello service
- envoy.yaml envoy proxy configuration
- generate-certificate.sh generates a new certificate
- renew-certificate.sh, 
  - generates a new certificate 
  - invoke the envoy proxy reload process
- cronjob, cronjob commands to execute renew-certificate.sh every 15 minutes
- startup.sh
  - generates inital certificate
  - start the python service
  - configure the cron
  - start the envoy proxy
- start-envoy.sh
  - starts the envoy proxy, used by the hot-restarter.py

## How it works

- The envoy proxy is started using the hot restart python wrapper "python3 hot-restarter.py start-envoy.sh"
- The certificate will be generated in regular interval
- After the certificate is generated, a SIGHUP signal is sent to the hot-restarter process
- hot-restarter process start the envoy reload process

## Reference

https://www.envoyproxy.io/docs/envoy/v1.6.0/intro/arch_overview/hot_restart

https://www.envoyproxy.io/docs/envoy/v1.6.0/operations/hot_restarter

https://github.com/envoyproxy/envoy/tree/ab7ab69d7976acacc7269acfc516cfb1f5836564/examples/front-proxy 
