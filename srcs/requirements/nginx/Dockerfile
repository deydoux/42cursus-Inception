ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache nginx

COPY nginx.conf /etc/nginx

COPY chat /var/www/chat

CMD ["nginx"]
