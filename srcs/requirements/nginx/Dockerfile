FROM debian:oldstable

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y nginx

COPY nginx.conf /etc/nginx

CMD ["nginx"]
