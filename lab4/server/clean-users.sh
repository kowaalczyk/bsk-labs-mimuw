#!/bin/bash

echo "Removing users..."

for i in {1..3}
do
    userdel u$i
    rm -rf /home/u$i
done

echo "Done"
