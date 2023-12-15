#!/bin/sh

set -e

trap 'cleanup' SIGTERM SIGINT

function cleanup {
  echo "# Trapped exit signal, cleaning up..."
  FW_DISABLE=1 /iptables.sh > /tmp/iptables-country
  /sbin/iptables-restore --test < /tmp/iptables-country
  /sbin/iptables-restore --counters < /tmp/iptables-country
  grep -e '^#' /tmp/iptables-country
  exit 0
}

if [[ -z $USE_IPSET ]]; then
  USE_IPSET=0
  if command -v ipset 2>&1 >/dev/null; then
    USE_IPSET=1
  fi
fi
export USE_IPSET

while true; do
  echo "# Blocking all traffic from countries: $COUNTRY_CODES"
  /iptables.sh > /tmp/iptables-country
  /sbin/iptables-restore --test < /tmp/iptables-country
  /sbin/iptables-restore --counters < /tmp/iptables-country
  grep -e '^#' /tmp/iptables-country
  sleep 365d
  echo "# Updating IP blocks from ipdeny.com"
  for c in ${FW_COUNTRY_CODES}; do \
    wget -O /zones/$c.zone -nv http://www.ipdeny.com/ipblocks/data/aggregated/$c-aggregated.zone; \
  done

done
