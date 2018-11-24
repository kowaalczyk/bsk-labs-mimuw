#!/bin/bash

echo "Generating ssh key..."
mkdir ~/.ssh > /dev/null 2>&1
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa > /dev/null 2>&1

echo "Adding configuration for students..."
ssh-keyscan -H students.mimuw.edu.pl >> ~/.ssh/known_hosts
cat students-ssh-config > ~/.ssh/config

echo "Done, now copy ssh key to students by executing following line as u1:"
echo "ssh-copy-id -i ~/.ssh/id_rsa kk385830@students.mimuw.edu.pl"
# TODO: Executing line above from su -c did not work (ssh authentication failing without displaying passwrord prompt)
