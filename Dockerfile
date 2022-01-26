FROM golang:1.17-alpine as builder
ARG ARCH="amd64"
ARG OS="linux"

COPY src /app/
WORKDIR /app/src

RUN go env -w GOPROXY=https://goproxy.cn,direct \
    && go env \
    && go get \
    && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o go-hello-test .

FROM alpine:latest
WORKDIR /app/
COPY --from=builder /app/src/ .
CMD [ "./go-hello-test" ]
