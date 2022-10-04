#!/bin/bash

JOB_NAME="containers_stats"
export LC_NUMERIC=POSIX

public_ip_address=$(host myip.opendns.com resolver1.opendns.com | grep "myip.opendns.com has" | awk '{print $4}')

while [ true ]
do
#cat << EOF | curl --data-binary @- ${PUSHGATEWAY_ENDPOINT}/metrics/job/${JOB_NAME}/instance/${public_ip_address}
  #echo -e "HTTP/1.1 200 OK\n\n$(docker stats --no-stream | grep -v CONTAINER | awk -f docker_stats_to_prometheus.awk)" | nc -l -k -p 8089;
  echo -e "HTTP/1.1 200 OK\n\n$(docker stats --no-stream | grep -v CONTAINER | awk -f docker_stats_to_prometheus.awk)" | nc -l -k -p ${STATS_TCP_PORT:-8089} -q 1;
#EOF
done
