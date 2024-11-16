ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache nginx

COPY nginx.conf /etc/nginx

RUN adduser -D -g www www
RUN chown -R www:www /var/lib/nginx

VOLUME ["/var/www"]

CMD ["nginx"]
