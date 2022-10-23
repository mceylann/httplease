#!/bin/bash

# v1
# 1 input: target domain
# no flags yet..

url=$1;

if [ ! -d "$url" ];then
	mkdir $url
fi

curl -s https://crt.sh/\?q\=%25.$url\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u > $url/assets.txt
echo "[+] Assets fetched -> assets.txt" 

echo "[+] Probe for working http and https servers.."
cat $url/assets.txt | httprobe -c 50 > $url/httplease.txt
cat $url/httplease.txt
echo "[+] Done."
