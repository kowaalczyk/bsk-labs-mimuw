#!/bin/bash

# Location of deployment virtual machine.
VM_HOST=localhost
VM_SSH_PORT=2222

# User used for deployment must have root access on the virtual machine 
# and will be prompted for password multiple times during the deployment process.
VM_USER=vmuser

# Working directory on the virtual machine (will NOT be created automatically).
# After deploy, palindrome executable, source code, user-helper.sh and Makefile will be present there,
# while temporary files will be removed if all actions succeeded.
VM_DEV_DIR=~/lab3

# Directory for palindrome pam config files on the virtual machine (will be created if necessary).
VM_CONFIG_DIR=/etc/palindrome.d


echo "Copying data to $VM_DEV_DIR..."
scp -P $VM_SSH_PORT -r src Makefile user-helper.sh scripts pam.d db $VM_USER@$VM_HOST:$VM_DEV_DIR/

echo "Creating palindrome config folder in $VM_CONFIG_DIR..."
ssh $VM_USER@$VM_HOST -p $VM_SSH_PORT -t "sudo mkdir $VM_CONFIG_DIR >/dev/null 2>&1"

echo "Setting up palindrome testtime script in $VM_CONFIG_DIR..."
ssh $VM_USER@$VM_HOST -p $VM_SSH_PORT -t "\
        sudo mv $VM_DEV_DIR/scripts/testtime.sh $VM_CONFIG_DIR/ \
        && sudo chown root:root $VM_CONFIG_DIR/testtime.sh \
        && sudo chmod +x $VM_CONFIG_DIR/testtime.sh \
        && rm -rf $VM_DEV_DIR/scripts"

echo "Creating Berkley DB file for proper storage of secondary password for root user"
ssh $VM_USER@$VM_HOST -p $VM_SSH_PORT -t "\
        sudo db_load -T -f $VM_DEV_DIR/db/after11.txt -t hash $VM_CONFIG_DIR/after11.db \
        && sudo db_load -T -f $VM_DEV_DIR/db/before11.txt -t hash $VM_CONFIG_DIR/before11.db \
        && sudo chown root:root $VM_CONFIG_DIR/after11.db $VM_CONFIG_DIR/before11.db \
        && sudo chmod 0600 $VM_CONFIG_DIR/after11.db $VM_CONFIG_DIR/before11.db \
        && rm -rf $VM_DEV_DIR/db"

echo "Setting up palindrome pam configuration..."
ssh $VM_USER@$VM_HOST -p $VM_SSH_PORT -t "\
        sudo mv $VM_DEV_DIR/pam.d/palindrome /etc/pam.d \
        && sudo chown root:root /etc/pam.d/palindrome \
        && sudo chmod 644 /etc/pam.d/palindrome \
        && rm -rf $VM_DEV_DIR/pam.d"

echo "Appending time access restrictions for palindrome to time.conf..."
ssh $VM_USER@$VM_HOST -p $VM_SSH_PORT -t "sudo bash -c "\""grep -q -F 'palindrome;*;*;Al1100-1130' /etc/security/time.conf || echo 'palindrome;*;*;Al1100-1130' >>/etc/security/time.conf"\"

echo "Compiling palindrome program..."
ssh $VM_USER@$VM_HOST -p $VM_SSH_PORT -t "\
        cd $VM_DEV_DIR \
        && make"

echo "Done."
