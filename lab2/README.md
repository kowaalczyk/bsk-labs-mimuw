# Lab 2

## Task

*[Original content (in polish)](http://smurf.mimuw.edu.pl/node/1867)*

The given program *crackme2018* calculates the control sum of a given ELF executable file and then compares it to one given as command line parameter.
You must prepare correct executable file and correct control sum for it.
You can run gdb on the *crackme2018* using the following command:

```
> gdb --args crackme05 /path/to/file checksum
```
The debug symbols were removed from the file. You can check that out using the *objdump* command:
```
> objdump --syms crackme05

crackme05:     file format elf32-i386

SYMBOL TABLE:
no symbols
```

The symbols were removed using strip utility.
It's now impossible to set a breakpoint at the start of main fuction using its name (i.e. typing `b main`).
Finding the correct address of the function main is not really that hard.
After the moment the C libraries are initialized, right after start of the process, control flow is redirected to the main function.
The *main* is called from insides of C libraries code. The details of that call can be observed on programs that have their symbols unstripped.
You can set the breakpoint in the *main*, run the program and look on the execution trace (`where` command).
You can see clearily the activation record *__libc_start_main* (it may be worth to see what are the parameters of that call).

In the case of stripped applciation you can firstly set the breakpoint on *__libc_start_main* and then deduce the *main* function address.

## Solution

In the directory next to readme you can find the following files:

* crackme2018 - the executable that was provided as a part of the task
* keygen.sh - a small script to generate the control sum

Just type the following command:
```
> ./keygen.sh <executable_name>
```

For example:
```
> ./keygen.sh crackme2018

  Please execute the following line to break into crackme2018 program:
  
  ./crackme2018 crackme2018 0x4d0cdf0d
  
```

Now you can just copy and paste the output `./crackme2018 crackme2018 0x4d0cdf0d` into the terminal to see the program accept the control sum.

The script is trivial and works using knowledge that address `0x80000c33` corresponds to the instruction where the control sum was calculated and places into `edx` register.

This can be determined using *objdump* or by using gdb on `./keygen.sh 123`, executing one instruction after another and searching for occurences of 123.
The application code is simple and it does not take long time to find out what's happening.

```
 c2e:   89 c2                   mov    edx,eax
 c30:   8b 45 dc                mov    eax,DWORD PTR [ebp-0x24]
 c33:   39 c2                   cmp    edx,eax                   <-- in edx resides the valid checksum and in eax the calculated one
 c35:   74 23                   je     c5a <close@plt+0x5ea>
 c37:   8b 83 e8 ff ff ff       mov    eax,DWORD PTR [ebx-0x18]
 c3d:   8b 00                   mov    eax,DWORD PTR [eax]
 c3f:   50                      push   eax
```


