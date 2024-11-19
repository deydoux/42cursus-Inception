FROM debian:oldstable

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y vsftpd

RUN mkdir -p /var/run/vsftpd/empty

COPY vsftpd.conf /etc

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["vsftpd", "/etc/vsftpd.conf"]
