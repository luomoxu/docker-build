# syntax = docker/dockerfile:experimental
# 1st build
FROM arm64v8/golang:latest as build-env

ARG VERSION="1.5.0"
ARG BUILD_PKGS="git automake libtool autoconf pkg-config curl libunbound-dev libhiredis-dev "

ENV GOOS linux
ENV GOARCH arm64
WORKDIR /go/src
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ${BUILD_PKGS} \
    && rm -rf /var/lib/apt/lists/*
RUN git config --global http.postBuffer 524288000
RUN git clone -b v${VERSION} --depth=1 https://github.com/coredns/coredns.git /go/src/github.com/coredns/coredns/
RUN cd /go/src/github.com/coredns/coredns/ \
   && make


# 2nd build
FROM alpine:latest
LABEL maintainer="kometchtech <kometch@gmail.com>" \
      arch="Aarch64" \
      description="CoreDNS (written in Go) chains plugins. Each plugin performs a DNS function." \
      url="https://github.com/coredns/coredns"

# Environment
ENV TZ Asia/Tokyo

# publish port DNS over UDP & TCP
EXPOSE 53/TCP 53/UDP

# service running
STOPSIGNAL SIGTERM

# Select entrypoint
WORKDIR /etc/coredns
ENTRYPOINT ["/coredns"]

# copy file 
#COPY --from=build-env /etc/ssl/certs /etc/ssl/certs
COPY --from=build-env /go/src/github.com/coredns/coredns/coredns /coredns

RUN apk add --update --no-cache ca-certificates tzdata
