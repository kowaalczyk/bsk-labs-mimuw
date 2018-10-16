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
