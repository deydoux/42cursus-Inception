ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache vsftpd

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
