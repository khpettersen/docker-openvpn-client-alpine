# docker-openvpn-client-alpine
Very simple openvpn client for alpine linux. Run in docker image.

# Build image
```
docker build -t ovpn-client .
```

# Correct DNS update of client when DNS information is provided from OPENVPN server
Assuming that you have an updated client config file from the OVPN server (client.conf, client.ovpn or similar).The config file has to be updated to ensure that DNS settings is updateded by Alpine Linux when the client is connecting to the OVPN server.
Add the following three lines at the start of the client.ovpn file:
```
script-security 2
up /etc/openvpn/up.sh
down /etc/openvpn/down.sh
```
The file would look something like this:
```
script-security 2
up /etc/openvpn/up.sh
down /etc/openvpn/down.sh
client
nobind
dev tun
remote-cert-tls server
remote X.X.X.X 1194 udp
.
.
```

Note that the up.sh and down.sh files are added automatically when the openvpn is installed on the Alpine system (by apk add openvpn). These are the only two files in the /etc/openvpn/ directory.
Note that on debian or ubuntu systems, a bash script called 'update-resolv-conf' is installed. This not applicabale for Alpine systems. In addition, 'update-resolv-conf' is a bash script which is not installed by default in Alpine.

# Run
```
docker run -d --cap-add=NET_ADMIN --device /dev/net/tun -v ~/shared:/vpn ovpn-client --config /vpn/client.ovpn --auth-nocache
```
