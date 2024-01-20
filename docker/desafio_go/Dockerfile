FROM golang:latest as builder

WORKDIR /usr/app

COPY ./app.go .

RUN go mod init app
RUN go build

FROM scratch
WORKDIR /app
COPY --from=builder /usr/app/app .

CMD ["./app"]