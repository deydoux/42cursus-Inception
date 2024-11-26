ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache curl

WORKDIR /srv
RUN curl -o index.php https://www.adminer.org/latest-mysql.php

CMD ["sleep", "infinity"]
