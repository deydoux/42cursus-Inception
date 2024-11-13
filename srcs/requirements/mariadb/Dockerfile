ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql
VOLUME ["/var/lib/mysql"]

RUN addgroup -S mariadb
RUN adduser -S mariadb -G mariadb
RUN chown mariadb:mariadb /run/mysqld /var/lib/mysql

COPY healthcheck.sh /usr/bin
HEALTHCHECK --interval=10s --timeout=5s --start-period=1s --retries=3 CMD ["healthcheck.sh"]

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["mariadbd", "--init-file=/run/secrets/initfile.sql", "--skip-networking=0", "--unix-socket=0"]
