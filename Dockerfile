FROM alpine:3.8

RUN apk add --no-cache openvpn openssh

#COPY update-resolv-conf /etc/openvpn/update-resolv-conf

ENTRYPOINT ["openvpn"]
VOLUME ["/vpn"]
