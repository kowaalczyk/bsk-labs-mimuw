# bsk-labs-mimuw
Solutions to some of the lab assignments from Security of Computer Systems Class, MIM UW 2018-19.

# Assignments  

## Lab 1
[Tasks' descriptions (in polish)](http://smurf.mimuw.edu.pl/node/1865)  
Solution consists of python script located in `lab1` directory + an attachment 
that can be pasted to `/etc/rsyslog.conf` which consists of following rules:  
```
# BSK LAB 1 (task #2)
# 1
*.=debug                                        /var/log/debug.log
*.=debug                                        ~
# 2
*.*;auth.none;authpriv.none;cron.none;lpr.none  /var/log/syslog
# 3
:msg,contains,"solutions"                       /var/log/students.log
# 4
kern.emerg;daemon.emerg                         *
lpr.warn;mail.warn;daemon.warn                  |/dev/xconsole
# END BSK LAB 1
```

## Lab 2  
**TODO**  

## Lab 3
[Tasks' description (in polish)](http://smurf.mimuw.edu.pl/node/1868)  

Solution consists of:  
- `palindome` executable that can be compiled from `src/palindrome.c` using `Makefile`
- `pam.d/palindrome`, `security/limits.conf`, and `security/time.conf` configuration changes
- `palindrome.d` configuration folder which contains config for palindrome pam rules

Solution is deployable to a virtual machine and requires a user with root access.  
Deployment process is split to 3 steps:  
1. `./deploy-helper.sh` is used to copy files to a vm, compile the program and set up 
pam configuration necessary for the program to be executed (tasks 1 & 2)  
2. `./user-helper.sh` is a script that is copied to vm and has to be executed as root 
in order to perform user-related configuration tasks (tasks 3-6)  
3. Some of the configuration has to be done manually, 
`user-helper.sh` will print the list of these tasks after its successful execution

Supplied deployment configuration is just an example and has to be configured for 
your own domain in order to work correctly - all configuration is made through 
variables defined at the top of both bash scripts.  

## Lab 4
**TODO**

## Lab 5
**TODO**
