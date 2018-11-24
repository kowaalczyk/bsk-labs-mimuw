#!/bin/bash

echo "Creating users with passwords..."

for i in {1..3}
do
    useradd -m u$i
    echo "u$i:Password$i" | chpasswd
    echo "u$i:Password$i"
done

echo "Done"
