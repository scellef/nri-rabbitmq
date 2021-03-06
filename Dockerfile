FROM golang:1.9 as builder
RUN go get -d github.com/newrelic/nri-rabbitmq/... && \
    cd /go/src/github.com/newrelic/nri-rabbitmq && \
    make && \
    strip ./bin/nr-rabbitmq

FROM newrelic/infrastructure:latest
COPY --from=builder /go/src/github.com/newrelic/nri-rabbitmq/bin/nr-rabbitmq /var/db/newrelic-infra/newrelic-integrations/bin/nr-rabbitmq
COPY --from=builder /go/src/github.com/newrelic/nri-rabbitmq/rabbitmq-definition.yml /var/db/newrelic-infra/newrelic-integrations/definition.yml
