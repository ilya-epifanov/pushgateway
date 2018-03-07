FROM golang:1.11.1 as builder

WORKDIR /go/src/github.com/prometheus/pushgateway

COPY . .
RUN make build

FROM        quay.io/prometheus/busybox:latest
LABEL maintainer "The Prometheus Authors <prometheus-developers@googlegroups.com>"

COPY --from=builder /go/src/github.com/prometheus/pushgateway/pushgateway /bin/pushgateway

EXPOSE     9091
RUN mkdir -p /pushgateway
WORKDIR    /pushgateway
ENTRYPOINT [ "/bin/pushgateway" ]
