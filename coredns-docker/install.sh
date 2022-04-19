#!/bin/bash
docker run -d \
  --restart always \
  --name coredns \
  -p 8053:8053/tcp \
  -p 8053:8053/udp \
  -v /Users/bluesgao/docker/coredns-docker/hosts:/etc/hosts \
  -v /Users/bluesgao/docker/coredns-docker/corefile:/corefile \
  coredns/coredns