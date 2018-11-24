#!/bin/bash

# make sure this is the same as in students-fs.sh
LOCAL_MOUNT_DIR=students-fs

echo "Unmouning and removing $LOCAL_MOUNT_DIR..."

fusermount -u $LOCAL_MOUNT_DIR
rmdir $LOCAL_MOUNT_DIR > /dev/null 2>&1

echo  "Done"
