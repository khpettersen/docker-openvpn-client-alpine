# docker-openvpn-client-alpine
Very simple openvpn client for alpine linux. Run in docker image.

### Build image
```
docker build -t ovpn-client .
```

### Correct DNS update of client when DNS information is provided from OPENVPN server
It is required that you have a client config file from the OVPN server (client.conf, client.ovpn or similar). The config file has to be updated to ensure that DNS settings is updateded by Alpine Linux when the client is connecting to the OVPN server.

Add the following three lines at the start of the client.ovpn file and place it in the ~/shared directory on the docker host:
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
These scripts are run inside the container when the client is connecting (up.sh) or disconnecting (down.sh). You need the 'script security 2' to allow running the up.sh or down.sh script. 

* Note that inside the container, the up.sh and down.sh files are added automatically when the openvpn is installed on the Alpine system (by apk add openvpn). These are the only two files in the /etc/openvpn/ directory.
* Note that on debian or ubuntu systems, a bash script called 'update-resolv-conf' is installed. This not applicabale for Alpine systems.

### Run
```
docker run -d --cap-add=NET_ADMIN --device /dev/net/tun -v ~/shared:/vpn ovpn-client --config /vpn/client.ovpn --auth-nocache
```
