FROM debian:oldstable

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends ca-certificates curl

ARG BUILDARCH
RUN curl -LO https://ollama.com/download/ollama-linux-$BUILDARCH.tgz
RUN tar -C /usr -xvf ollama-linux-$BUILDARCH.tgz
RUN rm ollama-linux-$BUILDARCH.tgz

COPY healthcheck.sh /usr/bin
HEALTHCHECK --interval=30s --timeout=10s --start-period=1s --retries=3 CMD ["healthcheck.sh"]

ENV OLLAMA_HOST 0.0.0.0:11434
CMD ["ollama", "serve"]
