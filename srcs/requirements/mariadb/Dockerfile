FROM alpine:3.19

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql
VOLUME ["/var/lib/mysql"]
COPY entrypoint.sh /usr/bin/docker-entrypoint.sh

RUN addgroup -S mariadb
RUN adduser -S mariadb -G mariadb
RUN chown mariadb:mariadb /run/mysqld /var/lib/mysql
USER mariadb

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mariadbd", "--init-file=/run/secrets/initfile.sql", "--skip-networking=0", "--unix-socket=0"]
