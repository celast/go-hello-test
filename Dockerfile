FROM golang:1.17-alpine as builder
ARG ARCH="amd64"
ARG OS="linux"

COPY src /app/src
WORKDIR /app/src

RUN ls
RUN go env -w GO111MODULE=on
RUN go env -w GOPROXY=https://goproxy.cn,https://goproxy.io,direct
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o go-hello-test .

FROM alpine:latest
WORKDIR /app/
COPY --from=builder /app/src/ .
CMD [ "./go-hello-test" ]
