# docker-openvpn-client-alpine

Openvpn client for alpine linux. Run in docker image.


# Build image

```
docker build -t ovpn-client .
```

# Run

```
docker run -d --cap-add=NET_ADMIN --device /dev/net/tun -v ~/shared:/vpn ovpn-client --config /vpn/config.ovpn --auth-nocache
```
