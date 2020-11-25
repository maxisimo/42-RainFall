# 1st Step
  
List the files will show us 'level0' executable
```
level0@RainFall:~$ ls -l
total 732
-rwsr-x---+ 1 level1 users 747441 Mar  6  2016 level0
level0@RainFall:~$ ./level0
Segmentation fault (core dumped)
level0@RainFall:~$ ./level0 a
No !
level0@RainFall:~$
```
The program segfault without parameters and print "No !" with a parameter.  
After analyze it with gdb we can find just a `main()`.  
Please refer to file [asm_analysis.md](https://github.com/maxisimo/42-RainFall/blob/main/level0/Ressources/asm_analysis.md) in parallel of [source.c](https://github.com/maxisimo/42-RainFall/blob/main/level0/source.c) for more details.  
The function 'atoi' is called. Then, the binary compares the firt arg with the number 423.  
By passing 423 as the firt argument, the program calls `setuid`, `getuid` and use `execv` to start a new /bin/sh process.
```
level0@RainFall:~$ ./level0 423
$ pwd
/home/user/level0
$ cat /home/user/level1/.pass
1fe8a524fa4bec01ca4ea2a869af2a02260d4a7d5fe7e7c24d8617e6dca12d3a
$ exit
level0@RainFall:~$ su level1
Password:
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level1/level1
level1@RainFall:~$
``` 
Level0 passed !
