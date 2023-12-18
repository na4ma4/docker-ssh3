FROM golang:1.21-bookworm as builder

WORKDIR /app

RUN curl -sL https://github.com/francoismichel/ssh3/archive/main.tar.gz | tar xz --strip-components 1

RUN go build -o ssh3 cli/client/main.go
RUN CGO_ENABLED=1 go build -o ssh3-server cli/server/main.go

FROM debian:bookworm

RUN useradd -m -U -u 1000 --shell "/bin/bash" --home-dir "/home/user" --comment "initial user" user

VOLUME [ "/home/user" ]

COPY --from=builder /app/ssh3-server /usr/local/bin/
COPY --from=builder /app/ssh3 /usr/local/bin/

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 443/tcp 443/udp

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
