# Docker SSH3 Test

Based on [francoismichel/ssh3](https://github.com/francoismichel/ssh3).

## Usage

Server:

```shell
docker run -ti --rm --name ssh3-server \
  -v "${HOME}/.ssh/authorized_keys:/home/user/.ssh/authorized_keys:ro" \
  -p 443:443/tcp -p 443:443/udp \
  ghcr.io/na4ma4/ssh3:latest -generate-selfsigned-cert -v -url-path /ssh3
```

Client:

```shell
./ssh3 -privkey ${HOME}/.ssh/id_rsa user@localhost/ssh3
```
