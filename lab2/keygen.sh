#!/bin/bash
#
# Piotr Styczynski
#  @styczynski
#
# MIT
#

#
# This line creates gdb code that sets the breakpoint at address where hash of input executable
# was calculated and then asks gdb gently to output all registers values
# We capture the registers and search for edx
#
printf "b *0x80000c33\nr ${1} 0\ninfo registers edx\nq\n" > ./gdb.input
out=$(gdb ./crackme2018 < ./gdb.input | tail -2 - | grep edx)

# Remove temporary trash
rm ./gdb.input
rm peda-session-*

# Format the gdb output nicely
value="${out##* }"
value=$(echo "$value" | awk '{print $1;}')

# Output the generated hash with full executable command
echo ""
echo "  Please execute the following line to break into crackme2018 program:"
echo ""
echo "  ./crackme2018 ${1} ${value}"
echo ""
