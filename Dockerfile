FROM golang:1.26-bookworm AS plugin-builder
RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates git gcc libc6-dev \
 && rm -rf /var/lib/apt/lists/*
RUN git clone --depth 1 https://github.com/xiaokuang95/cpa-plugin.git /src
WORKDIR /src/tokenharbor-cpa-plugin
RUN make build

FROM eceasy/cli-proxy-api:latest
COPY --from=plugin-builder /src/tokenharbor-cpa-plugin/tokenharbor.so /CLIProxyAPI/plugins/tokenharbor.so
EXPOSE 8317
