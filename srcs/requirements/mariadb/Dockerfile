ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache mariadb mariadb-client

COPY my.cnf /etc

RUN mkdir -p /run/mysqld /var/lib/mysql
RUN chown mysql:mysql /run/mysqld

COPY healthcheck.sh /usr/bin
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD ["healthcheck.sh"]

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["mariadbd", "--init-file=/run/secrets/initfile.sql"]
