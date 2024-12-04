ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache proftpd proftpd-mod_tls

RUN mkdir -p /run/proftpd

COPY proftpd.conf /etc/proftpd

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["proftpd", "-n"]
