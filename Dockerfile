FROM golang:1.13-alpine as builder

WORKDIR /go/src/github.com/iceman739/admission-webhook/

COPY . .

RUN GO111MODULE=on CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o admission-webhook

FROM alpine:latest

WORKDIR /

COPY --from=builder /go/src/github.com/iceman739/admission-webhook/admission-webhook /admission-webhook

ENTRYPOINT ["./admission-webhook"]
