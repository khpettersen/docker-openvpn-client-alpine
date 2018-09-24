FROM alpine:3.8
MAINTAINER Kjell H. Pettersen

RUN apk add --update --no-cache openvpn

ENTRYPOINT ["openvpn"]
VOLUME ["/vpn"]
