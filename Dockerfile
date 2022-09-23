FROM alpine:latest

ENV PUSHGATEWAY_ENDPOINT="http://pushgateway:9091"

RUN apk add docker-cli bash

COPY . .

VOLUME /var/run/docker.sock

EXPOSE 8089

ENTRYPOINT [ "/bin/bash", "stats.sh"]
