FROM debian:oldstable

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends ca-certificates curl

RUN curl -LO https://ollama.com/download/ollama-linux-amd64.tgz
RUN tar -C /usr -xzf ollama-linux-amd64.tgz
RUN rm ollama-linux-amd64.tgz

COPY healthcheck.sh /usr/bin
HEALTHCHECK --interval=30s --timeout=10s --start-period=1s --retries=3 CMD ["healthcheck.sh"]

CMD ["ollama", "serve"]
