#!/bin/bash

PUSHGATEWAY_ENDPOINT="http://localhost:9091"
JOB_NAME="containers_stats"
export LC_NUMERIC=POSIX

public_ip_address=$(host myip.opendns.com resolver1.opendns.com | grep "myip.opendns.com has" | awk '{print $4}')

while [ true ]
do
cat << EOF | curl --data-binary @- ${PUSHGATEWAY_ENDPOINT}/metrics/job/${JOB_NAME}/instance/${public_ip_address}
  docker stats --no-stream | grep -v CONTAINER | awk -f docker_stats_to_prometheus.awk
EOF
  sleep 5
done
