FROM alpine:3.19

RUN apk add --no-cache mariadb
RUN apk add --no-cache mariadb-client

RUN addgroup -S mariadb
RUN adduser -S mariadb -G mariadb

RUN mkdir -p /run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown mariadb:mariadb /run/mysqld /var/lib/mysql

COPY conf/* /etc/my.cnf.d

USER mariadb

RUN mariadb-install-db --datadir=/var/lib/mysql --skip-test-db

# CMD "/bin/sh"
CMD "mariadbd"
