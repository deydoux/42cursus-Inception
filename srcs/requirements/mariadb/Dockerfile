ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld
RUN chown -R mysql: /run/mysqld

COPY my.cnf /etc

COPY healthcheck.sh /usr/bin
HEALTHCHECK --interval=30s --timeout=10s --start-period=3s --retries=3 CMD ["healthcheck.sh"]

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["mariadbd", "--init-file=/run/secrets/initfile.sql"]
