#!/bin/bash

IP_TO_BLOCK=8.8.8.8

echo "2a, 2b: Appending config for to /etc/ssh/sshd_config..."
cat server-sshd-config >> /etc/ssh/sshd_config

echo "2c:"
echo "Manually append the public key for root login into"
echo "/root/.ssh/authorized_keys"

echo "2d: Machines from $IP_TO_BLOCK will be blocked via /etc/hosts.deny"
echo "# BSK lab4 zad 2d" >> /etc/hosts.deny
echo "sshd: $IP_TO_BLOCK" >> /etc/hosts.deny

echo "2e: Only accept protocol version 2"
echo "My machine runs OpenSSH 7.6 which deleted support for version 1, details:"
echo "https://www.openssh.com/txt/release-7.6"
echo "On older servers, I would reccommend updating the server to the latest version,"
echo "alternatively we could change Protocol 1,2 to Protocol 2 in sshd_config"

echo "Restarting server, make sure to do that after each change..."
echo "service ssh restart"
service ssh restart
echo "Done"
