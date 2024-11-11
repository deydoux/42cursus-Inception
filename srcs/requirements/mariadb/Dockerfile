FROM alpine:3.19

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld
RUN mkdir -p /var/lib/mysql

RUN addgroup -S mariadb
RUN adduser -S mariadb -G mariadb
RUN chown mariadb:mariadb /run/mysqld /var/lib/mysql

USER mariadb
RUN mariadb-install-db --datadir=/var/lib/mysql --skip-test-db

CMD ["mariadbd", "--init-file=/run/secrets/initfile.sql", "--skip-networking=0", "--unix-socket=0"]
