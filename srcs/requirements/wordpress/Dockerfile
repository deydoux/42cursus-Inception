ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["sleep", "infinity"]
