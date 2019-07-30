FROM envoyproxy/envoy-alpine

RUN apk update && apk add python3 bash curl openssl
RUN pip3 install --upgrade pip
RUN pip3 install -q Flask==0.11.1 requests==2.18.4

WORKDIR /opt/

COPY cronjob /opt/cronjob

COPY start-envoy.sh /opt/start-envoy.sh
RUN chmod u+x /opt/start-envoy.sh

COPY generate-certificate.sh /opt/generate-certificate.sh
RUN chmod u+x /opt/generate-certificate.sh

COPY renew-certificate.sh /opt/renew-certificate.sh
RUN chmod u+x /opt/renew-certificate.sh

ADD https://raw.githubusercontent.com/envoyproxy/envoy/master/restarter/hot-restarter.py /opt/hot-restarter.py

COPY envoy.yaml /opt/envoy.yaml

COPY startup.sh /opt/startup.sh
RUN chmod u+x /opt/startup.sh

RUN mkdir /opt/certs

COPY service.py /opt/service.py 

ENTRYPOINT /opt/startup.sh
