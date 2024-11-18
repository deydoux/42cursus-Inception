ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache vsftpd

COPY vsftpd.conf /etc/vsftpd

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
