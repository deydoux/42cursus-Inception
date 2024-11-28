ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION} AS download

RUN apk add --no-cache curl

RUN curl -LO https://ollama.com/download/ollama-linux-amd64.tgz


FROM debian:oldstable

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends ca-certificates

COPY --from=download ollama-linux-amd64.tgz ollama-linux-amd64.tgz

RUN tar -C /usr -xzf ollama-linux-amd64.tgz
RUN rm ollama-linux-amd64.tgz

CMD ["ollama", "serve"]
