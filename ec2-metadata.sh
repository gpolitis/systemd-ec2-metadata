#!/bin/bash

read request

while /bin/true; do
  read header
  [ "$header" == $'\r' ] && break;
done

url="${request#GET }"
url="${url% HTTP/*}"

if [ "$url" = '/latest/meta-data/' ]; then
  echo -e "HTTP/1.1 200 OK\r"
  echo -e "Content-Type: text/plain\r"
  echo -e "\r"
  echo -e "\r"
elif [ "$url" = '/latest/meta-data/local-ipv4' ]; then
  echo -e "HTTP/1.1 200 OK\r"
  echo -e "Content-Type: text/plain\r"
  echo -e "\r"
  echo $REMOTE_ADDR
  echo -e "\r"
elif [ "$url" = '/latest/meta-data/public-ipv4' ]; then
  echo -e "HTTP/1.1 200 OK\r"
  echo -e "Content-Type: text/plain\r"
  echo -e "\r"
  host `hostname` | awk '{print $NF}'
  echo -e "\r"
else
  echo -e "HTTP/1.1 404 Not Found\r"
  echo -e "Content-Type: text/html\r"
  echo -e "\r"
  echo -e "404 Not Found\r"
  echo -e "Not Found
           The requested resource was not found\r"
  echo -e "\r"
fi
