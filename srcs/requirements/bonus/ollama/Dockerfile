ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache curl

RUN curl -LO https://ollama.com/download/ollama-linux-amd64.tgz
RUN tar -C /usr -xzf ollama-linux-amd64.tgz
RUN rm ollama-linux-amd64.tgz

CMD ["sleep", "infinity"]
