FROM alpine:latest

# ca-certificates is needed if using SSL but not client certificates
RUN apk add --no-cache --update iptables wget

COPY *.sh /

ARG FW_COUNTRY_CODES
RUN set -ex; mkdir -p /zones; \
    for c in ${FW_COUNTRY_CODES}; do \
      wget -O /zones/$c.zone -nv http://www.ipdeny.com/ipblocks/data/aggregated/$c-aggregated.zone; \
    done
ENV COUNTRY_CODES=${FW_COUNTRY_CODES}

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["confd"]
