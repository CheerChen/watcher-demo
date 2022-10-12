FROM golang:alpine as builder

RUN apk add --no-cache make git

WORKDIR /src
COPY . /src

ENV GO111MODULE=on \
    GOPROXY=https://goproxy.cn,direct

RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -trimpath -ldflags '-w -s' .  && \
    mv watcher-demo /watcher-demo

FROM alpine:latest

COPY --from=builder /watcher-demo /

ENTRYPOINT ["/watwatcherch-demo"]