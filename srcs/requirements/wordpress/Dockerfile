ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache curl
RUN curl -o /root/wordpress_latest.tar.gz "https://wordpress.org/latest.tar.gz"

RUN adduser -D -g wordpress wordpress
VOLUME ["/var/www"]

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["sleep", "infinity"]
