ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION}

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["sleep", "infinity"]
