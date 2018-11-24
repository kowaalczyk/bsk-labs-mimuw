#!/bin/bash

STUDENTS_DIR=/home/students/inf/k/kk385830/bsk-tmp
LOCAL_MOUNT_DIR=students-fs

echo "3a: Mounting students:"
mkdir $LOCAL_MOUNT_DIR > /dev/null 2>&1
sshfs students:$STUDENTS_DIR $LOCAL_MOUNT_DIR

echo "3b, 3c: Copying BSK public directory..."
rsync -r students:/home/students/inf/PUBLIC/BSK .
echo "Use -z for compression if necessary"
echo "Use --exclude '*.ext' in order to exclude files with .ext extension"
echo "Use -a to use archive mode (copy symlinks, etc.)"
