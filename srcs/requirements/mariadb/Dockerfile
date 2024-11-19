FROM debian:oldstable

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y mariadb-server

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

COPY mariadb.cnf /etc/mysql

COPY healthcheck.sh /usr/bin
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD ["healthcheck.sh"]

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["mariadbd", "--init-file=/run/secrets/initfile.sql"]
