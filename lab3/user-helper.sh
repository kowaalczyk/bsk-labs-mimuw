#!/bin/bash

# this script sets up configuration according to points 3-6 from the assignment
# execute this as root on the VM

# credentials for generated users
USERNAME1=luser1
USERPASS1=Password1
USERNAME2=luser2
USERPASS2=Password2

useradd $USERNAME1
echo "$USERNAME1    hard    maxlogins   2" >>/etc/security/limits.conf
echo "$USERNAME1    hard    nproc   20" >>/etc/security/limits.conf
echo "$USERNAME1:$USERPASS1" | chpasswd

useradd luser2
echo "palindrome;!tty2&tty3&tty4;$USERNAME2;!Al0000-2400" >> /etc/security/time.conf
echo "$USERNAME2:$USERPASS2" | chpasswd

echo "Add following line to /etc/sudoers using visudo:"
echo "$USERNAME2    ALL=(ALL:ALL) /usr/sbin/tcpdump"
