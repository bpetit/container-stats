FROM alpine:latest

RUN apk add docker-cli

COPY . .

VOLUME /var/run/docker.sock

ENTRYPOINT [ "/bin/bash", "stats.sh"]
